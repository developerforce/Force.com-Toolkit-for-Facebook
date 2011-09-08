/**
 * Base graph API object. All other Facebook Objects should extend this base class.
 * @author Quinton Wall - qwall@salesforce.com
 * @author Gastón Esmela - gesmela@salesforce.com
 * @author Pat Patterson - ppatterson@salesforce.com
 */
public virtual class FacebookObject { 
	public static String graphuri = 'https://graph.facebook.com/';
	public static String cookieName = 'fbsession';
	public static boolean testmode { get; set; }
	public static String teststubresponse;
	public String accessToken;
	
	public Result result {get;set;}
	
	// We have to take an accessToken in the constructor
	// as cookies are not always accessible - e.g. if we're
	// running in a remoting context
	public FacebookObject(String accessToken){
		this.result = new Result();
		this.accessToken = accessToken;
	}
	
	/**
	 * Set this to allow us to write test methods
	 */
	public void setTestStubResponse(String s) {
		testmode = true;
		teststubresponse = s;
	}
	
	
	/**
	 * does the actual call to the graph API.
	 */
	public void doAPICall(String id, String connection, map<string,string> params) {
		if(id != null && id != ''){	
			if (accessToken != null){
				// Call params
			    if (params == null) {
			    	params = new Map<String,String>();
			    }
			    
			    // Add the access token (required)
			    params.put('access_token', accessToken);
			    
			    // Preppend slash to connection
	    	    		connection = (connection != null && connection != '') ? ('/'+connection) : '';
			    
			   	String endpoint = graphuri+id+connection+paramStringFromMap(params);
			   	
			   	this.doAPICall(endpoint);
			} else {
				this.result.hasError = true;
				this.result.errorType = 'AuthenticationError';
				this.result.errorMessage = 'Access token is missing.';
			}
		}
		else {
			System.debug('FacebookToolkit(Base) Error: ID cannot be null/empty to make an API Call.');
			this.result.hasError = true;
			this.result.errorType = 'InvalidID';
			this.result.errorMessage = 'ID cannot be null/empty to make an API Call.';
		}
	}
	
	public void doAPICall(String url) {
    	result.jsonString = doAPICallRaw(url);
    	result.data = new JSONObject( new JSONObject.JSONTokener(result.jsonString));
		processResult();
	}
	
    public String doAPICallRaw(String id, String connection, map<string,string> params) {
        if(id != null && id != ''){ 
	        // Call params
	        if (params == null) {
	            params = new Map<String,String>();
	        }
	        
	        // Add the access token (required)
	        params.put('access_token', accessToken);
	        
	        // Prepend slash to connection
	        connection = (connection != null && connection != '') ? ('/'+connection) : '';
	        
	        String endpoint = graphuri+id+connection+paramStringFromMap(params);
	        
	        return doAPICallRaw(endpoint);
        } else {        	
            System.debug('FacebookToolkit(Base) Error: ID cannot be null/empty to make an API Call.');
            throw new FacebookException('ID cannot be null/empty to make an API Call.');
        }
    }
    
    public static String doAPICallRaw(String url) {
    		String response;
    	
        if(testmode == true) {
            System.debug('TEST API RESP: '+teststubresponse);
            
            response = teststubresponse;
        } else {
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod('GET');
            req.setTimeout(60*1000);
            
            HttpResponse res = h.send(req);
            response = res.getBody();
            
            if (res.getStatusCode() >= 400) {
                throw new FacebookException('Received '+res.getStatusCode()+' from '+url);
            }
            
            //fb returns a 302 temp redirect with the url for the profile image
            if(res.getStatusCode() == 302)
            {
                System.debug('Received a 302, Header Location value is:'+res.getHeader('Location'));
                response = '{"data": [{"url": "'+res.getHeader('Location')+'"},]}';
            } 
            
            System.debug('API RESP: '+response);
        }
        return response;
    }
    
	
    /**
     * This methods makes a POST to write to graph
     * Jeff Douglas (jeff@appirio.com)
     */
    public void doAPIPost(String method, Map<String, String> params) {
    
        Http h = new Http();
	    HttpRequest req = new HttpRequest();
	    req.setMethod('POST');
	    if (params != null)
            req.setBody(postBodyStringFromMap(params)); 
   
        if(testmode == true) {
            teststubresponse = 'Status=OK, StatusCode=200';
        } else {  
            req.setEndpoint('https://graph.facebook.com/'+method+'?access_token='+accessToken);
            
            HttpResponse res = h.send(req);
            
            if(res.getStatusCode() != 200) {
                System.debug('Error POSTing to Graph: '+res);
                System.debug('Request: '+req);
                System.debug('Body: ' + req.getBody());
            }
        }
    } 
    
	/**
	 * This methods constructs the param string from a param Map.
	 */
	public static String paramStringFromMap(Map<String,String> params){
		String returned = '';
		for(String key : params.keySet()){
			if(returned == ''){
				returned += '?';
			}
			else {
				returned += '&';
			}
			//returned += key+'='+EncodingUtil.urlEncode(params.get(key), 'UTF-8');
			returned += key+'='+params.get(key);
			
		}
		return returned;
	} 
	
    /**
     * This methods constructs the param string for a post from a param Map.
     * Jeff Douglas (jeff@appirio.com)
     */
    public static String postBodyStringFromMap(Map<String,String> params){
        String returned = '';
        for (String key : params.keySet()) {
            if (returned != '') {
                returned += '&';
            }
            returned += key+'='+EncodingUtil.urlEncode(params.get(key), 'UTF-8');  
        }    
      
        return returned;
    }
    
	/**
	 * This method will check if the api returned any error , and if so log it in the system debug.
	 */
	public void processResult(){
		if(this.result.data.getValue('error') != null){
			this.result.errorType = this.result.data.getValue('error').obj.getString('type');
			this.result.errorMessage = this.result.data.getValue('error').obj.getString('message');
			this.result.hasError = true;
			
			System.debug('FacebookToolkit(Base) Error: '+this.result.errorType+' : '+this.result.errorMessage);
		}
	}
	 
	/**
	 * Inner class to hold result information.
	 */
	public class Result{
		public String jsonString {get;set;}
		public JSONObject data {get;set;}
		
		public Boolean hasError {get;set;}
		public String errorType {get;set;}
		public String errorMessage {get;set;}
		
		public String nextPage {get{
			if(this.nextPage == null && this.hasPaging()){
				this.nextPage = this.data.getValue('paging').obj.getValue('next').str.replace('\\','');
			}
			return this.nextPage;
		}set;}
		
		public String prevPage {get{
			if(this.prevPage == null && this.hasPaging()){
				this.prevPage = this.data.getValue('paging').obj.getValue('previous').str.replace('\\','');
			}
			return this.prevPage;
		}set;}
		
		public boolean hasPaging(){
			JSONObject.value page = data.getValue('paging');
			return page != null;
		}
	} 
	
}