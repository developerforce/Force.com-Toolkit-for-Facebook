public class FacebookUtil {
	public static Boolean testmode { get; set; }
	public static String teststubresponse;
	public static String graphuri = 'https://graph.facebook.com/';
	
	static {
		testmode = false;
	}
	
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
	
	public static void consumeObject(JSONParser parser) {
		Integer depth = 0;
		do {
			JSONToken curr = parser.getCurrentToken();
			if (curr == JSONToken.START_OBJECT || 
				curr == JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == JSONToken.END_OBJECT ||
				curr == JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}

    private static String doGet(String url) {
    	String response;
    	
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        req.setTimeout(60*1000);
        
        HttpResponse res;
        if (testmode) {
        	res = new HttpResponse();
        	response = teststubresponse;
        } else {
	        res = h.send(req);
	        response = res.getBody();        	
        }
        
        if (res.getStatusCode() >= 400) {
            throw new FacebookException('Received '+res.getStatusCode()+' from '+url+'\n'+response);
        }
        
        //fb returns a 302 temp redirect with the url for the profile image
        if(res.getStatusCode() == 302)
        {
            System.debug('Received a 302, Header Location value is:'+res.getHeader('Location'));
            response = '{"data": [{"url": "'+res.getHeader('Location')+'"},]}';
        } 
        
        System.debug('API RESP: '+response);

        return response;
    }
    
	public static String get(String accessToken, String id, Map<String, String> params) {
		if(id != null && id != ''){ 
	        // Call params
	        if (params == null) {
	            params = new Map<String,String>();
	        }

	        // Add the access token (required)
	        params.put('access_token', accessToken);

	        String endpoint = graphuri + id + paramStringFromMap(params);

	        return doGet(endpoint);
        } else {        	
            System.debug('FacebookToolkit(Base) Error: ID cannot be null/empty to make an API Call.');
            throw new FacebookException('ID cannot be null/empty to make an API Call.');
        }
	}
	
	public static String get(String accessToken, String id) {
		return get(accessToken, id, null);
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
     * This methods makes a POST to write to graph
     * Jeff Douglas (jeff@appirio.com)
     */
    public static void post(String accessToken, String resource, Map<String, String> params) {
    
        Http h = new Http();
	    HttpRequest req = new HttpRequest();
	    req.setMethod('POST');
	    if (params != null) {
            req.setBody(postBodyStringFromMap(params));
	    } 
   
        req.setEndpoint(graphuri+resource+'?access_token='+accessToken);
        
        HttpResponse res;
        if(testmode) {
        	res = new HttpResponse();
        } else {
	        res = h.send(req);
        }
        
        if(res.getStatusCode() != 200) {
            System.debug('Error POSTing to Graph: '+res);
            System.debug('Request: '+req);
            System.debug('Body: ' + req.getBody());
            throw new FacebookException('FacebookUtil.post received '+res.getStatusCode()+' '+res.getStatus()+'\n'+req.getBody());
        }
    }

    public static void deleteItem(String accessToken, String resource) {
    	String response;
    	
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('DELETE');
        req.setEndpoint(graphuri+resource+'?access_token='+accessToken);
        req.setTimeout(60*1000);

        HttpResponse res;
        if (testmode) {
        	res = new HttpResponse();
        } else {
		    res = h.send(req);
		    response = res.getBody();
        }
        
        if (res.getStatusCode() >= 400) {
            throw new FacebookException('Received '+res.getStatusCode()+' '+res.getStatus()+' deleting '+req.getEndpoint()+'\n'+response);
        }
        
        System.debug('API RESP: '+response);
    }

	static testMethod void testUtil() {
		testmode = true;
		
		deleteItem('TEST', 'me');
	}
}