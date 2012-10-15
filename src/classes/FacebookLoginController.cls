/**
 * @author Pat Patterson - ppatterson@salesforce.com
 */

public virtual class FacebookLoginController {
	public String logoutUrl { get; set; }
	
    // Return a default - the first FB app we find - this will be fine for 
    // many cases but can be overridden in subclasses if there are multiple 
    // FB apps in the org 
    public virtual String getAppId() {
        List<FacebookApp__c> fapps = [SELECT clientID__c FROM FacebookApp__c];
        if ( fapps.size() == 0 ) {
            throw new FacebookException('No FacebookApp__c records found. '+
                'Do you need to go and create one?');
        }
        return fapps[0].clientID__c;
    }
    
    public virtual String getPermissions() {
    	return '';
    }

    public virtual String getAccessToken() {
    	return FacebookToken.getAccessToken();
    }

    public virtual Boolean getAutoLogin() {
    	return false;
    }
    
    String getPageURL() {
        // Get a URL for the page without any query params    
        String url = ApexPages.currentPage().getUrl().split('\\?')[0];        
        System.debug('url is '+url);
        
    	return url;
    }
    
    public String getRedirectURI() {
        String redirectURI = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+'/apex/FacebookCallback';
        System.debug('redirectURI is:'+redirectURI);
        
        return redirectURI;
    }
    
    PageReference getAuthURI() {
    	FacebookApp__c app = getApp();
    	
        System.debug('Facebook OAuth Step 1');
    
        String scope = (app.permissions__c != null && app.permissions__c != '') ?
            ('&scope='+app.permissions__c.replace(';', ',')) : '';
            
        String state = '&state='+getPageURL();
            
        String authURI = 'https://graph.facebook.com/oauth/authorize?client_id='+
                        app.clientID__c+'&redirect_uri='+getRedirectURI()+scope+state;
                        
        System.debug('authURI is:'+authURI);
                        
        return new PageReference(authURI);
    }
    
    public FacebookApp__c getApp() {
        List<FacebookApp__c> fapps = [SELECT clientID__c, clientSecret__c, permissions__c 
            FROM FacebookApp__c 
            WHERE clientID__c = :getAppId()];

        if ( fapps.size() == 0 ) {
            throw new FacebookException('No FacebookApp__c record found for app id '+getAppId()+
               '. Do you need to go and create one?');
        }
        
    	return fapps[0];
    }

	// Explicit login request - return the FB authorization URI
    public virtual PageReference login() {
    	return getAuthURI();
    }
    
    // Page initialization - handle auto-login and FB authorization code
    public virtual PageReference init() {        
    	if ( getAutoLogin() ) {
	        String sessionId = FacebookToken.getAccessToken();
	        
	        if (sessionId != null) {
	            // Check that we can access FB
	            try {
	                FacebookUtil.get(sessionId, 'me', new Map<String, String>{'fields' => 'id'});
	            } catch (FacebookException e) {
	                System.Debug('Expired access token? '+e.getMessage());
	                FacebookToken.deleteAccessToken();
	                sessionId = null;
	            }
	        }
	        
	        System.debug('sessionid='+sessionId);
	        if (sessionId != null) {
	            // All done                
	            return null;
	        }
	        
	        // No session
	        
            // Initial step of OAuth - redirect to FB OAuth service	            
            return getAuthURI();
    	} else {
    		return null;
    	}
    }
    
    public virtual PageReference logout() {
    	FacebookToken.deleteAccessToken();

		// Set a logout URL if you're using the login action on your page!    	
    	PageReference pageRef = (logoutUrl != null) 
    		? new PageReference(logoutUrl) 
    		: ApexPages.currentPage();
    	pageRef.setRedirect(true);
    	
    	return pageRef;
    }
    
    static testMethod void testController() {
        PageReference pageRef = Page.FacebookSamplePage;
        
        Test.setCurrentPage(pageRef);
        
        FacebookLoginController controller = new FacebookLoginController();
        
        PageReference nextPageRef = controller.init();
        
        // Default init returns null
        System.assertEquals(null, nextPageRef);
        
        Test.setCurrentPage(pageRef);
        
        controller = new FacebookLoginController();
        
        nextPageRef = controller.login();    
        
        // Did we get redirected to FB?
        System.assert(nextPageRef.getUrl().startsWith('https://graph.facebook.com/oauth/authorize'));        
    }
}