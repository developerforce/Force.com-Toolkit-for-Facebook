/**
 * @author Pat Patterson - ppatterson@salesforce.com
 */

global with sharing class FacebookSampleController extends FacebookLoginController {
    // Returns JSON string with user info
    public static String getFacebookUser() {
    	FacebookObject fbo = new FacebookObject(FacebookToken.getAccessToken());

        return fbo.doAPICallRaw('me', null, null);
    }

    public static String getAccessToken() {
    	return FacebookToken.getAccessToken();
    }

	// Can't get the cookies in a remote method, so pass it in explicitly
    @RemoteAction
    global static String getFriends(String accessToken) {
    	FacebookObject fbo = new FacebookObject(accessToken);

        return fbo.doAPICallRaw('me', 'friends', null);    	
    }
}