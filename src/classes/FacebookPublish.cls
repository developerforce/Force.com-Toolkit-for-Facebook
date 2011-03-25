/**
 * FacebookPublish handles most write operations to the Facebook Graph API.
 * @author Jeff Douglas
 */

public class FacebookPublish extends FacebookObject {
  
  public String id {get;set;}
  
  public FacebookPublish(String id) {
    super();
    this.id = id;
  } 
  
  /**
  * Publish a new post on the given profile's feed/wall. Method is 'PROFILE_ID/feed'.
  * Applicable arguments: message, picture, link, name, caption, description and source.
  */
  public void postToWall(Map<String,String> params) {  
    this.doAPIPost(this.id+'/feed', params);
  }
  
  /**
  * Comment on the given object (if it has a /comments connection). 
  * Method is 'OBJECT_ID/comments'. Applicable arguments: message.
  */
  public void postComment(String objectId, Map<String,String> params) {
  	this.doAPIPost(objectId+'/comments', params);
  }
  
  /**
  * Like the given object (if it has a /likes connection). 
  * Method is 'OBJECT_ID/likes'. Applicable arguments: none.
  */
  public void postLike(String objectId) {
    this.doAPIPost(objectId+'/likes',null);
  }
  
  /**
  * Publish a note on the given profile. 
  * Method is 'PROFILE_ID/notes'. Applicable arguments: message, subject.
  */
  public void postNote(Map<String,String> params) {
    this.doAPIPost(this.id+'/notes',params);
  }
  
  /**
  * Publish a link on the given profile.
  * Method is 'PROFILE_ID/links'. Applicable 
  * arguments: link, message, picture, name, caption, description.
  */
  public void postLink(Map<String,String> params) {
    this.doAPIPost(this.id+'/links',params);
  }
  
  /**
  * Create a checkin at a location represented by a Page. 
  * Method is 'PROFILE_ID/checkins'. Applicable 
  * arguments: coordinates, place, message, tags.
  * !! Requires the publish_checkins permission.
  */
  public void postCheckin(Map<String,String> params) {
    this.doAPIPost(this.id+'/checkins',params);
  }
  
  /**
  * Create an event. Method is 'PROFILE_ID/events'. 
  * Applicable arguments: name, start_time, end_time.
  */
  public void postEvent(Map<String,String> params) {
    this.doAPIPost(this.id+'/events',params);
  }

}