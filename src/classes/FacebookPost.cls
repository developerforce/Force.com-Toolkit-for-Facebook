/**
 * Facebook Post handles the data of POST Objects of the Facebook Graph API
 * Future features: getPostById , Comments Connection, Comment Pagination.
 * 
 * @author Quinton Wall - qwall@salesforce.com
 * @author Gastón Esmela - gesmela@salesforce.com
 */

public class FacebookPost extends FacebookObject {	
	public String id {get;set;}
	public String name {get;set;}
	public String description {get;set;}
	public String caption {get;set;}
	public String message {get;set;}
	public String picture {get;set;}
	public String link {get;set;}
	public String icon {get;set;}
	public String itemType {get;set;}
	public String source {get;set;}
	public String privacyValue {get;set;}
	public String privacyDescription {get;set;}
	public Long likes {get;set;}
	public String created_time {get;set;}
	public String updated_time {get;set;}
	
	public String fromId {get;set;}
	public String fromName {get;set;}
	public String fromCategory {get;set;}
	
	public List<ToInfo> to {get;set;}
	public List<FacebookComment> comments {get;set;}
	public List<Actions> actions {get;set;}
	
	
	/**
	 * Constructor
	 */
	public FacebookPost(String id){	
		super();
		this.id = id;
	}
	public FacebookPost(JSONObject data){	
		super();
		this.result.data = data;
		this.id = data.getString('id');
		this.parsePost();
	}
	
	public Boolean getHasComments(){
		if(this.comments != null ) return this.comments.size()>0;
		else return false;
	}
	
	public Boolean getHasTo(){
		if(this.to != null ) return this.to.size()>0;
		else return false;
	}
	
	/**
	 * JSON Parsing.
	 */
	public void parsePost(){
		this.name = this.result.data.getString('name');
		this.description = this.result.data.getString('description');
		this.message = this.result.data.getString('message');
		this.caption = this.result.data.getString('caption');
		this.picture = this.result.data.getString('picture');
		this.link = this.result.data.getString('link');
		this.icon = this.result.data.getString('icon');
		this.itemType = this.result.data.getString('type');
		this.source = this.result.data.getString('source');
		this.created_time = this.result.data.getString('created_time');
		this.updated_time = this.result.data.getString('updated_time');
		
		JSONObject.value likes = this.result.data.getValue('likes');
		if(likes != null)
			this.likes = likes.num;

		JSONObject.value fromv = this.result.data.getValue('from');
		if(fromv != null) {	
			this.fromId = fromv.obj.getString('id');
			this.fromName = fromv.obj.getString('name');
			this.fromCategory = fromv.obj.getString('category');
		}
		
		JSONObject.value privacy = this.result.data.getValue('privacy');
		if(privacy != null){	
			this.privacyValue = privacy.obj.getString('value');
			this.privacyDescription = privacy.obj.getString('description');
		}
		
		JSONObject.value toValue = this.result.data.getValue('to');
		if(toValue != null){
			this.to = new List<ToInfo>();
			if(toValue.obj.getValue('data') != null){
				JSONObject.value[] vals = toValue.obj.getValue('data').values;
				for(Integer i = 0; i < vals.size(); i++){
					this.to.add(new ToInfo(vals[i].obj));
				}
			}
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
		/*
		JSONObject.value actionsValue = this.result.data.getValue('actions');
		if(actionsValue != null){
			this.actions = new List<Actions>();
			if(actionsValue.obj.getValue('data') != null){
				JSONObject.value[] vals = actionsValue.obj.getValue('data').values;
				for(Integer i = 0; i < vals.size(); i++){
					this.actions.add(new Actions(vals[i].obj));
				}
			}	
		}*/
		
	}
	
	
	public class Actions {
		public String name {get;set;}
		public String link {get;set;} 
		
		public Actions(JSONObject data){
			this.name = data.getString('name');
			this.link = data.getString('link');
		}
	}
	public class ToInfo {
		public String id {get;set;}
		public String name {get;set;} 
		
		public ToInfo(JSONObject data){
			this.id = data.getString('id');
			this.name = data.getString('name');
		}
	}
}