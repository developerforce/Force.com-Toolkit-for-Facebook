/**
* @author Quinton Wall - qwall@salesforce.com
 * @author Gastón Esmela - gesmela@salesforce.com
 */

public class FacebookStatusMessage extends FacebookObject {	
	public String id {get;set;}
	public String message {get;set;}
	public String updated_time {get;set;}
	
	public String fromId {get;set;}
	public String fromName {get;set;}
	public String fromCategory {get;set;}
	
	public List<FacebookComment> comments {get;set;}
	
	/**
	 * Constructor
	 */
	public FacebookStatusMessage(String id){	
		super();
		this.id = id;
	}
	
	public FacebookStatusMessage(JSONObject data){	
		super();
		this.result.data = data;
		this.id = data.getString('id');
		this.parseStatusMessage();
	}
	
	public Boolean getHasComments(){
		if(this.comments != null ) return this.comments.size()>0;
		else return false;
	}
	
	/**
	 * JSON Parsing.
	 */
	public void parseStatusMessage(){
		this.message = this.result.data.getString('message');
		this.updated_time = this.result.data.getString('updated_time');
		
		JSONObject.value fromv = this.result.data.getValue('from');
		if(fromv != null) {	
			this.fromId = fromv.obj.getString('id');
			this.fromName = fromv.obj.getString('name');
			this.fromCategory = fromv.obj.getString('category');
		}
		
		JSONObject.value commentsValue = this.result.data.getValue('comments');
		if(commentsValue != null){
			this.comments = new List<FacebookComment>();
			if(commentsValue.obj.getValue('data') != null){
				JSONObject.value[] vals = commentsValue.obj.getValue('data').values;
				for(Integer i = 0; i < vals.size(); i++){
					this.comments.add(new FacebookComment(vals[i].obj));
				}
			}
		}	
	}
}