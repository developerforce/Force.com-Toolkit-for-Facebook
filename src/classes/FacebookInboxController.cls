/**
 * @author Pat Patterson - ppatterson@salesforce.com
 */

global with sharing class FacebookInboxController extends FacebookLoginController {
	// Set this to an auth provider id (e.g. '0SOD00000000012') to use an 
	// auth provider (new in Spring '12)
	private static String authProviderId = null;

	public String error {get; set;}

	public FacebookInboxController() {
	}
	
	// You wouldn't usually need to override init(). We do here to be able
	// to change the behavior depending on whether we want to use the platform
	// auth provider. If you want to use the auth provider in your controller,
	// just don't extend FacebookLoginController
	public override PageReference init() {
		return ( authProviderId == null ) ? super.init() : null;
	}
	
    public static String getAccessToken() {
    	return ( authProviderId == null ) 
    		? FacebookToken.getAccessToken()
    		: Auth.AuthToken.getAccessToken(authProviderId, 'facebook');
    }

	public FacebookThreads myThreads {
		get {
			try {
				String accessToken = getAccessToken();
				
				if (accessToken != null) {
					FacebookUser me = new FacebookUser(accessToken, 'me');
					
					myThreads = new FacebookThreads(accessToken, 'me/inbox', null);
					// Remove 'me' from the thread participants
					for (FacebookThread thread : myThreads.data) {
						for (Integer i = 0; i < thread.to.data.size(); i++) {
							if (thread.to.data[i].id == me.id) {
								thread.to.data.remove(i);
								break;
							}
						}
					}
				}				
			} catch (Exception e) {
				error = e.getMessage();
			}
			
			return myThreads;
		} set;
	}
	
    static testMethod void testController() {
    	// TODO
    }
}