/**
 * @author Pat Patterson - ppatterson@salesforce.com
 */

global with sharing class FacebookSampleController extends FacebookLoginController {
	public String message {get; set;}
	public String postId {get; set;}
	public String userData {get; set;} 
	
	public FacebookSampleController() {
		userData = 'null';
	}
	
	public FacebookUser me {
		get {
			// Can't set up 'me' in the controller constructor, since the superclass
			// 'login' method won't have been called!
			if (me == null) {
				String accessToken = getAccessToken();
				
				// If accessToken is null, it's likely that the page's action 
				// method has not yet been called, so we haven't been to FB to
				// get an access token yet. If this is the case, we can just 
				// leave 'me' as null, since the redirect will happen before
				// HTML is send back.
				if (accessToken != null) {
					me = new FacebookUser(accessToken, 'me');
				}
			}
			
			return me;
		} set;
	}
	
	public FacebookPosts myPosts {
		get {
			String accessToken = getAccessToken();
			
			if (accessToken != null) {
				myPosts = new FacebookPosts(accessToken, 'me/feed', null);
			}				
			
			return myPosts;
		} set;
	}
	
    // Returns JSON string with user info
    public String getFacebookUser() {
        return userData;
    }
    
    public PageReference getUserData() {
        userData = FacebookUtil.get(getAccessToken(), 'me');
        
        return null;
    }
    
    public static String getAccessToken() {
    	return FacebookToken.getAccessToken();
    }

	// Can't get the cookies in a remote method, so pass it in explicitly
    @RemoteAction
    global static String getFriends(String accessToken) {
        return FacebookUtil.get(accessToken, 'me/friends');
    }

    public PageReference postToFeed() {
    	if (message != null) {
    		FacebookPublish.postToWall(getAccessToken(), 'me', new Map<String, String>{'message' => message});
    	}
    	
    	message = null;

    	return null;
    }
    
    public PageReference deletePost() {
    	if (postId != null) {
    		FacebookUtil.deleteItem(getAccessToken(), postId);
    	}
    	
    	postId = null;
    	
    	return null;
    }
    
    static testMethod void testController() {
    	// TODO
    }
}