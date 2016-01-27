public with sharing class FacebookCallbackController extends FacebookLoginController {
    // Page initialization - handle FB authorization code
    public override PageReference init() {
        if (ApexPages.currentPage().getParameters().containsKey('error_code')) {
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 
				'error_code=' + ApexPages.currentPage().getParameters().get('error_code')));
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,
                ApexPages.currentPage().getParameters().get('error_message')));
        	return null;
        } else if (ApexPages.currentPage().getParameters().containsKey('error')) {
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 
				ApexPages.currentPage().getParameters().get('error')));
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,
                ApexPages.currentPage().getParameters().get('error_description')));
        	return null;
        } else if (! ApexPages.currentPage().getParameters().containsKey('code')) {
        	ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Missing code parameter');
        	ApexPages.addMessage(msg);
        	return null;
        }
        
        // Get token from FB OAuth service
        FacebookApp__c app = getApp();
            
        String code = ApexPages.currentPage().getParameters().get('code');
        System.debug('Facebook OAuth Step 2 - code:'+code);
        
        String state =  ApexPages.currentPage().getParameters().get('state');
        System.debug('state:'+state);
                
        String tokenURI = 'https://graph.facebook.com/oauth/access_token?client_id='+
                        app.clientID__c+'&redirect_uri='+getRedirectURI()+
                        '&client_secret='+FacebookCrypto.decrypt(app.clientSecret__c)+'&code='+code;                    
        System.debug('tokenURI is:'+tokenURI);
                
        HttpRequest req = new HttpRequest();
        req.setEndpoint(tokenURI);
        req.setMethod('GET');
        req.setTimeout(60*1000);
        
        Http h = new Http();
        String response;
        if (code.equals('TEST')) {
            response = 'access_token=TEST&expires=3600';
        } else {
            HttpResponse res = h.send(req);
            response = res.getBody();
        }
    
        System.debug('Facebook response is:'+response); 
        
        try {
        	FacebookToken.setAccessToken(response);
        } catch (FacebookException e) {
        	ApexPages.addMessages(e);
        	return null;        	
        }
            
        // Note the dummy parameter - this is required because FB
        // puts #_ on the end of the URL, which seems to confuse VF -
        // we get %23_ appended to the url after the redirect. Adding 
        // a dummy parameter means that the VF page name is not 
        // corrupted - the parameter takes the hit and ends up as 
        // a=b%23_ :-)
        PageReference pageRef = new PageReference(state+'?a=b');
        pageRef.setRedirect(true);
		return pageRef;
    }
    
    static testMethod void testController() {
    	// Create an app in the test context
    	FacebookApp__c app = new FacebookApp__c(clientID__c = 'TEST', clientSecret__c = FacebookCrypto.encrypt('TEST'), permissions__c = 'TEST');
    	insert app;
    	
    	String url = 'http://test.example.com/';
    	PageReference pageRef = Page.FacebookCallback;
    	
        pageRef.getParameters().put('code', 'TEST');
        pageRef.getParameters().put('state', url);
  
        Test.setCurrentPage(pageRef);
        
        FacebookCallbackController controller = new FacebookCallbackController();
        
        PageReference nextPageRef = controller.init();
        
        // Was the test access token set?
        System.assertEquals('TEST', FacebookToken.getAccessToken());
        
        // Did we get redirected back to the page?
        System.assertEquals(url+'?a=b', nextPageRef.getUrl());
        System.assert(nextPageRef.getRedirect());    	
    }
}