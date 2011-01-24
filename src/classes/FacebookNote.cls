/**
 * @author Gastón Esmela - gesmela@salesforce.com
 */
public class FacebookNote extends FacebookObject {	
	public String id {get;set;}
	public String message {get;set;}
	public String icon {get;set;}
	public String subject {get;set;}
	public Long likes {get;set;}
	public String created_time {get;set;}
	public String updated_time {get;set;}
	
	public String fromId {get;set;}
	public String fromName {get;set;}
	public String fromCategory {get;set;}
	
	public List<FacebookComment> comments {get;set;}
	
	/**
	 * Constructor
	 */
	public FacebookNote(String id){	
		super();
		this.id = id;
	}
	public FacebookNote(JSONObject data){	
		super();
		this.result.data = data;
		this.id = data.getString('id');
		this.parseNote();
	}
	
	public Boolean getHasComments(){
		if(this.comments != null ) return this.comments.size()>0;
		else return false;
	}
	
	/**
	 * JSON Parsing.
	 */
	public void parseNote(){	
		this.message = this.result.data.getString('message');
		this.icon = this.result.data.getString('icon');
		this.subject = this.result.data.getString('subject');
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