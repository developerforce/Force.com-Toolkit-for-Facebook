/**
 * Base graph API object. All other Facebook Objects should extend this base class.
 * @author Quinton Wall - qwall@salesforce.com
 * @author Gastón Esmela
 */
public abstract class FacebookObject { 
	public String graphuri = 'https://graph.facebook.com/';
	public boolean testmode { get; set; }
	public String teststubresponse;
	
	public String accesstoken;
	public String clientId {get;set;}
	public Result result {get;set;}
	
	public FacebookObject(){
		this.result = new Result();
	}
	
	
	/**
	 * Check if the user is authenticated in the app.
	 */
	public boolean isAuthenticated(){
		if(testmode != null && testmode == true){
			return true;
		}
		else {
			FacebookApp__c fapp = [select AccessToken__c, lastModifiedDate from FacebookApp__c where clientID__c =:this.clientId];
			System.debug('FAPP='+fapp);
			
			//access tokens last 		elsefor 2 hours, unless a extended perm is used
			//if(fapp.AccessToken__c == null || hasTokenExpired(fapp.lastModifiedDate))
			
			if(fapp.AccessToken__c == null)
				return false;
			else {
				this.accesstoken = fapp.AccessToken__c;
				return true;
			}
		}
	}
	
	
	/**
	 * Facebook provides access tokens for a period of 2hours before expiring them
	 */
	private boolean hasTokenExpired(Datetime lastmod) {
		if(lastmod.addHours(2) < DateTime.now())
		{
			System.debug(LoggingLevel.INFO, 'FACEBOOK ACCESS TOKEN IS OK');
			return true;
		}
		else
		{
			System.debug(LoggingLevel.INFO, 'FACEBOOK ACCESS TOKEN HAS EXPIRED');
			return false;
		}
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
			if(this.isAuthenticated()){
			
				// Call params
			    if(params == null) params = new Map<String,String>();
			    // Add the access token (required)
			    params.put('access_token',this.accesstoken);
			    
			    // Preppend slash to connection
			    if (connection != null && connection != '') connection = '/'+connection; 
			  	else connection = '';
			   	String endpoint = graphuri+id+connection+this.paramStringFromMap(params);
			   	
			   	this.doAPICall(endpoint);
			}
			else {
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
		if(testmode == true) {
			System.debug('TEST API RESP: '+teststubresponse);
	    	
	    	this.result.jsonString = teststubresponse;
	    	this.result.data = new JSONObject( new JSONObject.JSONTokener(teststubresponse));
		}
		else {
			Http h = new Http();
		    HttpRequest req = new HttpRequest();
		    req.setEndpoint(url);
		    req.setMethod('GET');
		    HttpResponse res = h.send(req);
		    String response = res.getBody();
		    
		    //fb returns a 302 temp redirect with the url for the profile image
		    if(res.getStatusCode() == 302)
		    {
		    	System.debug('Received a 302, Header Location value is:'+res.getHeader('Location'));
		    	response = '{"data": [{"url": "'+res.getHeader('Location')+'"},]}';
		    	
		    }
		    else
		    	this.result.jsonString = response; 
		    
		    System.debug('API RESP: '+response);
		   	this.result.data = new JSONObject( new JSONObject.JSONTokener(response));
		}
		this.processResult();
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
      req.setBody(this.postBodyStringFromMap(params)); 
   
    if(testmode == true) {
    	teststubresponse = 'Status=OK, StatusCode=200';
    } else {  
   
		  if(this.isAuthenticated()){

        req.setEndpoint('https://graph.facebook.com/'+method+'?access_token='+this.accesstoken);
		    HttpResponse res = h.send(req);
		    
				if(res.getStatusCode() != 200) {
				  System.debug('Error POSTing to Graph: '+res);
				  System.debug('Request: '+req);
				  System.debug('Body: ' + req.getBody());
				}
		    
		  }
	  
    }
    
  }	
	
	/**
	 * This methods constructs the param string from a param Map.
	 */
	public String paramStringFromMap(Map<String,String> params){
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
  public String postBodyStringFromMap(Map<String,String> params){
    String returned = '';
    for(String key : params.keySet()) {
      if(returned != '')
        returned += '&';
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