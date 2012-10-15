public with sharing class FacebookToken {
    public static String cookieName = 'fbsession';

    /**
     * Get the access token for the current user
     */
    public static String getAccessToken(){
        if (Test.isRunningTest()){
            return 'TEST';
        } else {
            if (ApexPages.currentPage() == null) {
                throw new FacebookException('ApexPages.currentPage() is null - Facebook API not supported');
            }
            if (ApexPages.currentPage().getCookies().get(cookieName) == null) {
                return null;
            }
            if (ApexPages.currentPage().getParameters().containsKey('code')) {
                // We're still doing the login flow with Facebook - we've set 
                // the access token, but we need to let the redirect complete
                // to avoid the "You have uncommitted work pending. Please 
                // commit or rollback before calling out" error
                return null;
            }
            String sessionid = ApexPages.currentPage().getCookies().get(cookieName).getValue();
            
            List<FacebookSession__c> sessions = [SELECT SessionId__c, AccessToken__c 
                FROM FacebookSession__c 
                WHERE SessionId__c = :sessionid];
            
            System.debug('sessionid='+sessionid);
            System.debug('sessions='+sessions.size());
            
            if(sessions.size() == 0 || sessions[0].AccessToken__c == null) {
                return null;
            }
            
            return FacebookCrypto.decrypt(sessions[0].AccessToken__c);
        }
    }
    
    public static void setAccessToken(String response) {
        //response in format of access_token=XXXXX&expires=YYYY
        String accessToken = '';
        Integer expires = 3600;
        Integer acc = response.indexOf('access_token');
        if ( acc == -1 ) {
            throw new FacebookException('No access token in Facebook response: '+response);
        }
        Integer amp = response.indexOf('&');
        if ( amp == -1 ) {
            accessToken = response.substring(acc + 13, response.length());
        } else {
            accessToken = response.substring(acc + 13, amp);
        }
        Integer exp = response.indexOf('expires');
        if ( exp != -1 ) {
            amp = response.indexOf('&', exp);
            if ( amp == -1 ) {
                expires = Integer.valueOf(response.substring(exp + 8, response.length()));
            } else {
                expires = Integer.valueOf(response.substring(exp + 8, amp));
            }
        }
        
        System.debug('Access token: '+accesstoken+' expires: '+expires);

        // Generate 128 bit random session ID
        String sessionId = Crypto.getRandomLong().format() + Crypto.getRandomLong().format();
        System.debug('new sessionid='+sessionId);
        if (ApexPages.currentPage() == null) {
            throw new FacebookException('ApexPages.currentPage() is null - Facebook API not supported');
        }
        ApexPages.currentPage().setCookies(new Cookie[]{new Cookie(cookieName,sessionId,null,-1,false)});

        insert new FacebookSession__c(AccessToken__c = FacebookCrypto.encrypt(accessToken), SessionId__c = sessionId, Expiry__c = DateTime.now().addSeconds(expires));
    }
    
    public static void deleteAccessToken() {
        if (ApexPages.currentPage() == null) {
            throw new FacebookException('ApexPages.currentPage() is null - Facebook API not supported');
        }
        if (ApexPages.currentPage().getCookies().get(cookieName) == null) {
            return;
        }
        String sessionid = ApexPages.currentPage().getCookies().get(cookieName).getValue();
        
        List<FacebookSession__c> sessions = [SELECT SessionId__c, AccessToken__c 
            FROM FacebookSession__c 
            WHERE SessionId__c = :sessionid];
        
        System.debug('sessionid='+sessionid);
        System.debug('sessions='+sessions.size());
        
        if(sessions.size() > 0) {
           delete sessions[0];
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
}