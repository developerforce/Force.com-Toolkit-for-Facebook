/**
 * FacebookPublish handles most write operations to the Facebook Graph API.
 * @author Jeff Douglas
 */

public class FacebookPublish {
  
  /**
  * Publish a new post on the given profile's feed/wall. Method is 'PROFILE_ID/feed'.
  * Applicable arguments: message, picture, link, name, caption, description and source.
  * !! Requires the publish_stream permission.
  */
  public static void postToWall(String accessToken, String id, Map<String,String> params) {  
    FacebookUtil.post(accessToken, id+'/feed', params);
  }
  
  /**
  * Comment on the given object (if it has a /comments connection). 
  * Method is 'OBJECT_ID/comments'. Applicable arguments: message.
  */
  public static void postComment(String accessToken, String id, Map<String,String> params) {
    FacebookUtil.post(accessToken, id+'/comments', params);
  }
  
  /**
  * Like the given object (if it has a /likes connection). 
  * Method is 'OBJECT_ID/likes'. Applicable arguments: none.
  */
  public static void postLike(String accessToken, String id) {
    FacebookUtil.post(accessToken, id+'/likes',null);
  }
  
  /**
  * Publish a note on the given profile. 
  * Method is 'PROFILE_ID/notes'. Applicable arguments: message, subject.
  */
  public static void postNote(String accessToken, String id, Map<String,String> params) {
    FacebookUtil.post(accessToken, id+'/notes',params);
  }
  
  /**
  * Publish a link on the given profile.
  * Method is 'PROFILE_ID/links'. Applicable 
  * arguments: link, message, picture, name, caption, description.
  */
  public static void postLink(String accessToken, String id, Map<String,String> params) {
    FacebookUtil.post(accessToken, id+'/links',params);
  }
  
  /**
  * Create a checkin at a location represented by a Page. 
  * Method is 'PROFILE_ID/checkins'. Applicable 
  * arguments: coordinates, place, message, tags.
  * !! Requires the publish_checkins permission.
  */
  public static void postCheckin(String accessToken, String id, Map<String,String> params) {
    FacebookUtil.post(accessToken, id+'/checkins',params);
  }
  
  /**
  * Create an event. Method is 'PROFILE_ID/events'. 
  * Applicable arguments: name, start_time, end_time.
  */
  public static void postEvent(String accessToken, String id, Map<String,String> params) {
    FacebookUtil.post(accessToken, id+'/events',params);
  }

  /**
   * Test methods for publishing
   * Jeff Douglas (jeff@appirio.com)
   */   
  public static testmethod void TestPublish() {
        Map<String,String> params = new Map<String,String>();
        params.put('test','test');
        
        String expectedExceptionPrefix = 'FacebookUtil.post received';
        
        Test.startTest();
        FacebookUtil.testmode = true;
        
        try {
        	FacebookPublish.postToWall('DUMMY_ACCESS_TOKEN', 'me', params);
        	System.assert(false);
        } catch (FacebookException fbe) {
        	System.assert(fbe.getMessage().startsWith(expectedExceptionPrefix));
        }

        try {
	        FacebookPublish.postEvent('DUMMY_ACCESS_TOKEN', 'me', params);
        	System.assert(false);
        } catch (FacebookException fbe) {
        	System.assert(fbe.getMessage().startsWith(expectedExceptionPrefix));
        }
	        
        try {
		    FacebookPublish.postCheckin('DUMMY_ACCESS_TOKEN', 'me', params);
        	System.assert(false);
        } catch (FacebookException fbe) {
        	System.assert(fbe.getMessage().startsWith(expectedExceptionPrefix));
        }
		    
        try {
		    FacebookPublish.postLink('DUMMY_ACCESS_TOKEN', 'me', params);
        	System.assert(false);
        } catch (FacebookException fbe) {
        	System.assert(fbe.getMessage().startsWith(expectedExceptionPrefix));
        }
		    
        try {
		    FacebookPublish.postNote('DUMMY_ACCESS_TOKEN', 'me', params);
        	System.assert(false);
        } catch (FacebookException fbe) {
        	System.assert(fbe.getMessage().startsWith(expectedExceptionPrefix));
        }
		    
        try {
		    FacebookPublish.postLike('DUMMY_ACCESS_TOKEN', 'me');
        	System.assert(false);
        } catch (FacebookException fbe) {
        	System.assert(fbe.getMessage().startsWith(expectedExceptionPrefix));
        }
		    
        try {
		    FacebookPublish.postComment('DUMMY_ACCESS_TOKEN', 'me', params);
        	System.assert(false);
        } catch (FacebookException fbe) {
        	System.assert(fbe.getMessage().startsWith(expectedExceptionPrefix));
        }
        
        Test.stopTest();
    }   
}