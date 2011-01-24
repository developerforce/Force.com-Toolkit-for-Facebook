/**
 * @author Quinton Wall - qwall@salesforce.com
 * @author Gastón Esmela - gesmela@salesforce.com
 */

public class FacebookAlbum extends FacebookObject{
	public String id { get;set; }
	public String name { get;set; }
	public String description {get;set;}
	public String location { get;set; }
	public String link { get;set; }
	public String privacy { get;set; }
	public String count { get;set; }
	public String created_time {get;set;}
	public String updated_time { get;set; }
	
	public String fromId {get;set;}
	public String fromName {get;set;}
	public String fromCategory {get;set;}
	
	public List<FacebookComment> comments {get;set;}
	/**
	 * Constructor
	 */
	public FacebookAlbum(String id){	
		super();
		this.id = id;
	}
	public FacebookAlbum(JSONObject data){	
		super();
		this.result.data = data;
		this.id = data.getString('id');
		this.parseAlbum();
	}
	
	public Boolean getHasComments(){
		if(this.comments != null ) return this.comments.size()>0;
		else return false;
	}
	
	
	public void parseAlbum(){
		this.name = this.result.data.getString('name');
		this.description = this.result.data.getString('description');
		this.location = this.result.data.getString('location');
		this.privacy = this.result.data.getString('privacy');
		this.count = this.result.data.getString('count');
		this.link = this.result.data.getString('link');
		this.created_time = this.result.data.getString('created_time');
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