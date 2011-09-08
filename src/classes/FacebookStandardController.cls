/*
 * Handles OAuth2 requests to FB
 * @author Quinton Wall - qwall@salesforce.com
 */
public class FacebookStandardController 
{
	public  string accessToken { get; set; }
	public  string fbID { get; set; }
	
	public  string clientSecret { get; set; }
	public  string code { get; set; }
	public  string recordId { get; set; }
	public  string appName { get; set; }
	public  string facebookUname { get; set; }
	
	public FacebookStandardController()
	{
		System.debug('IN CONS');
		//get the sfdc record id of the app we are going to call.
		if(recordId == null)
		{
			System.debug('SETTING RECORDID');
			recordId = ApexPages.currentPage().getParameters().get('id'); 
		}
	}	
	
	public String getProfileImageUrl()
	{
		FacebookUser u = new FacebookUser(FacebookToken.getAccessToken(), fbID);
		return u.getProfilePicture();
	}
}