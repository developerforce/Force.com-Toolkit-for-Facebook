/**
 * @author Pat Patterson - ppatterson@salesforce.com
 */

global with sharing class FacebookSampleController extends FacebookLoginController {
	// Set this to an auth provider id (e.g. '0SOD00000000012') to use an 
	// auth provider (new in Spring '12)
	private static String authProviderId = null;

	public String message {get; set;}
	public String postId {get; set;}
	public String userData {get; set;} 
	public String error {get; set;}
	
	public FacebookSampleController() {
		userData = 'null';
	}
	
	// You wouldn't usually need to override init(). We do here to be able
	// to change the behavior depending on whether we want to use the platform
	// auth provider. If you want to use the auth provider in your controller,
	// just don't extend FacebookLoginController
	public override PageReference init() {
		return ( authProviderId == null ) ? super.init() : null;
	}
	
    public override String getAccessToken() {
    	return ( authProviderId == null ) 
    		? super.getAccessToken()
    		: Auth.AuthToken.getAccessToken(authProviderId, 'facebook');
    }

	public FacebookUser me {
		get {
			try {
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
			} catch (Exception e) {
				error = e.getMessage();
			}
			
			return me;
		} set;
	}
	
	public FacebookPosts myPosts {
		get {
			try {
				String accessToken = getAccessToken();
				
				if (accessToken != null) {
					myPosts = new FacebookPosts(accessToken, 'me/feed', null);
				}				
			} catch (Exception e) {
				error = e.getMessage();
			}
			
			return myPosts;
		} set;
	}
	
    // Returns JSON string with user info
    public String getFacebookUser() {
        return userData;
    }
    
    public PageReference getUserData() {
		error = null;
		
		try {
	        userData = FacebookUtil.get(getAccessToken(), 'me');
		} catch (Exception e) {
			error = e.getMessage();
		}
        
        return null;
    }
    
	// Can't get the cookies in a remote method, so pass it in explicitly
    @RemoteAction
    global static String getFriends(String accessToken) {
    	String friends = null;
    	
		try {
    	    friends = FacebookUtil.get(accessToken, 'me/friends');
		} catch (Exception e) {
			// Can't set the error message in a static method, so let's
			// just return it
			friends = e.getMessage();
		}
		
		return friends;
    }

    public PageReference postToFeed() {
		error = null;
		
		try {
	    	if (message != null) {
	    		FacebookPublish.postToWall(getAccessToken(), 'me', new Map<String, String>{'message' => message});
	    	}
	    	
	    	message = null;
		} catch (Exception e) {
			error = e.getMessage();
		}

    	return null;
    }
    
    public PageReference deletePost() {
		error = null;
		
		try {
	    	if (postId != null) {
	    		FacebookUtil.deleteItem(getAccessToken(), postId);
	    	}
	    	
	    	postId = null;
		} catch (Exception e) {
			error = e.getMessage();
		}
    	
    	return null;
    }
    
    static testMethod void testController() {
    	// TODO
    }
}