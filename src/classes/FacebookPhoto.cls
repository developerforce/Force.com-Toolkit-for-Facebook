/**
 * @author Quinton Wall - qwall@salesforce.com
 * @author Gastón Esmela - gesmela@salesforce.com
 */

public class FacebookPhoto extends FacebookObject{
	public String id { get;set; }
	public String name { get;set; }
	public String picture { get;set; }
	public String source { get;set; }
	public Integer height { get;set; }
	public Integer width { get;set; }
	public String link { get;set; }
	public String icon { get;set; }
	public String created_time {get;set;}
	public String updated_time { get;set; }
	
	public String fromId {get;set;}
	public String fromName {get;set;}
	public String fromCategory {get;set;}
	
	public List<FacebookComment> comments {get;set;}
	public List<photoTag> tags {get;set;}
	
	
	/**
	 * Constructor
	 */
	public FacebookPhoto(String id){	
		super();
		this.id = id;
	}
	public FacebookPhoto(JSONObject data){	
		super();
		this.result.data = data;
		this.id = data.getString('id');
		this.parsePhoto();
	}
	
	public Boolean getHasComments(){
		if(this.comments != null ) return this.comments.size()>0;
		else return false;
	}
	
	public void parsePhoto(){
		this.name = this.result.data.getString('name');
		this.picture = this.result.data.getString('picture');
		this.link = this.result.data.getString('link');
		this.icon = this.result.data.getString('icon');
		this.source = this.result.data.getString('source');
		this.created_time = this.result.data.getString('created_time');
		this.updated_time = this.result.data.getString('updated_time');
		this.height = this.result.data.getValue('height').num;
		this.width = this.result.data.getValue('width').num;
		
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
		
		JSONObject.value tagsValue = this.result.data.getValue('tags');
		if(tagsValue != null){
			this.tags = new List<photoTag>();
			if(tagsValue.obj.getValue('data') != null){
				JSONObject.value[] vals = tagsValue.obj.getValue('data').values;
				for(Integer i = 0; i < vals.size(); i++){
					this.tags.add(new photoTag(vals[i].obj));
				}
			}
		}

	}
	
	
	public class photoTag {
		public String id {get;set;}
		public String name {get;set;}
		public Double x {get;set;}
		public Double y {get;set;}
		public String created_time {get;set;}
		
		public photoTag (JSONObject data){
			this.id = data.getString('id');
			this.name = data.getString('name');
			this.x = data.getValue('x').dnum;
			this.y = data.getValue('y').dnum;
			this.created_time = data.getString('created_time');
		}
	}	

}