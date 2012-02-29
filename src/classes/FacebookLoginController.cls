/**
 * @author Pat Patterson - ppatterson@salesforce.com
 */

public virtual class FacebookLoginController {
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

    public virtual PageReference login() {
        List<FacebookApp__c> fapps = [SELECT clientID__c, clientSecret__c, permissions__c 
            FROM FacebookApp__c 
            WHERE clientID__c = :getAppId()];

        if ( fapps.size() == 0 ) {
            throw new FacebookException('No FacebookApp__c record found for app id '+getAppId()+
               '. Do you need to go and create one?');
        }
        
        // Get a URL for the page without any query params    
        String url = ApexPages.currentPage().getUrl().split('\\?')[0];
        
        System.debug('url is '+url);

        // note: connect url in fb application connect setting should be: https://c.na3.visual.force.com/apex/
        // you need the trailing slash even though it bitches about it
        String rediruri = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+url;

        System.debug('rediruri is:'+rediruri);
        
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
        String exPerms = (fapps[0].permissions__c != null && fapps[0].permissions__c != '') ?
            ('&scope='+fapps[0].permissions__c.replace(';', ',')) : '';
        PageReference pageRef;
        
        if (! ApexPages.currentPage().getParameters().containsKey('code')) {
            // Initial step of OAuth - redirect to FB OAuth service
            System.debug('Facebook OAuth Step 1');
        
            String authuri = 'https://graph.facebook.com/oauth/authorize?client_id='+
                            fapps[0].clientID__c+'&redirect_uri='+rediruri+exPerms;
                            
            pageRef = new PageReference(authuri);
        } else {
            // Second step of OAuth - get token from FB OAuth service
            String code = ApexPages.currentPage().getParameters().get('code');

            System.debug('Facebook OAuth Step 2 - code:'+code);
                
            String authuri = 'https://graph.facebook.com/oauth/access_token?client_id='+
                            fapps[0].clientID__c+'&redirect_uri='+rediruri+exPerms+
                            '&client_secret='+FacebookCrypto.decrypt(fapps[0].clientSecret__c)+'&code='+code;                    
            System.debug('authuri is:'+authuri);
                
            HttpRequest req = new HttpRequest();
            req.setEndpoint(authuri);
            req.setMethod('GET');
            req.setTimeout(60*1000);
        
            Http h = new Http();
            String resp;
            if (code.equals('TEST')) {
                resp = 'access_token=TEST&expires=3600';
            } else {
                HttpResponse res = h.send(req);
                resp = res.getBody();
            }
    
            System.debug('FINAL RESP IS:'+resp); 
            
            FacebookToken.setAccessToken(resp);
                
            // Come back to this page without the code param
            // We need to do this to commit the DML before any callouts
            //
            // Note the dummy parameter - this is required because FB
            // puts #_ on the end of the URL, which seems to confuse VF -
            // we get %23_ appended to the url after the redirect. Adding 
            // a dummy parameter means that the VF page name is not 
            // corrupted - the parameter takes the hit and ends up as 
            // a=b%23_ :-)
            pageRef = new PageReference(url+'?a=b');
            pageRef.setRedirect(true);
        }
        
        return pageRef;
    }
    
    static testMethod void testController() {
        PageReference pageRef = Page.FacebookSamplePage;
        
        // We'll need the URL later to check we're being redirected to 
        // the right place
        String url = pageRef.getUrl().split('\\?')[0];
        
        Test.setCurrentPage(pageRef);
        
        FacebookLoginController controller = new FacebookLoginController();
        
        PageReference nextPageRef = controller.login();
        
        // Did we get redirected to FB?
        System.assert(nextPageRef.getUrl().startsWith('https://graph.facebook.com/oauth/authorize'));
        
        Test.setCurrentPage(pageRef);
        
        pageRef.getParameters().put('code', 'TEST');
  
        nextPageRef = controller.login();
        
        // Did we get redirected back to the page?
        System.assertEquals(nextPageRef.getUrl(), url+'?a=b');
        System.assert(nextPageRef.getRedirect());
    }
}