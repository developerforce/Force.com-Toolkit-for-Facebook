/**
* @author Quinton Wall - qwall@salesforce.com
 * @author Gastón Esmela - gesmela@salesforce.com
 */

public class FacebookLink extends FacebookObject {	
	public String id {get;set;}
	public String name {get;set;}
	public String description {get;set;}
	public String caption {get;set;}
	public String message {get;set;}
	public String picture {get;set;}
	public String link {get;set;}
	public String icon {get;set;}
	public String created_time {get;set;}

	public String fromId {get;set;}
	public String fromName {get;set;}
	public String fromCategory {get;set;}

	public List<FacebookComment> comments {get;set;}
	
	/**
	 * Constructor
	 */
	public FacebookLink(String id){	
		super();
		this.id = id;
	}
	public FacebookLink(JSONObject data){	
		super();
		this.result.data = data;
		this.id = data.getString('id');
		this.parseLink();
	}
	
	public Boolean getHasComments(){
		if(this.comments != null ) return this.comments.size()>0;
		else return false;
	}
	
	/**
	 * JSON Parsing.
	 */
	public void parseLink(){
		this.name = this.result.data.getString('name');
		this.description = this.result.data.getString('description');
		this.message = this.result.data.getString('message');
		this.caption = this.result.data.getString('caption');
		this.picture = this.result.data.getString('picture');
		this.link = this.result.data.getString('link');
		this.icon = this.result.data.getString('icon');
		this.created_time = this.result.data.getString('created_time');
		
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