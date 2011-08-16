/**
 * Common methods for the fb social components
 * @author: qwall@salesforce.com
*/
public class FacebookSocialController {

	public static String FB_ACTIVITY_URL = 'https://www.facebook.com/plugins/activity.php';
	public static String FB_LIKE_URL = 'https://www.facebook.com/widgets/like.php';
	public static String FB_RECOMMENDATIONS_URL = 'https://www.facebook.com/plugins/recommendations.php';
	
 	public String getSiteUrl()
    {
        return Site.getCurrentSiteUrl();
    }
    
    public String getActivityURL()
    {
    	return FB_ACTIVITY_URL;
    }
    
     public String getLikeURL()
    {
    	return FB_LIKE_URL;
    }
    
     public String getRecommendationsURL()
    {
    	return FB_RECOMMENDATIONS_URL;
    }

}