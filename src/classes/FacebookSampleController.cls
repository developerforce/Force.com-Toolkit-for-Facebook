/**
 * @author Pat Patterson - ppatterson@salesforce.com
 */

global with sharing class FacebookSampleController extends FacebookLoginController {
    // Returns JSON string with user info
    public static String getFacebookUser() {
        return FacebookObject.doAPICallRaw('me', null, null);
    }    
}