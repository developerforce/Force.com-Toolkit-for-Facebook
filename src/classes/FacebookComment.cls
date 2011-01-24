/*
 * @author Quinton Wall - qwall@salesforce.com
 */
public class FacebookComment extends FacebookObject{
	JSONObject data;
		
	public String id {get;set;}
	public String message {get;set;}
	public String created_time {get;set;}
	
	public String fromId {get;set;}
	public String fromName {get;set;}
	public String fromCategory {get;set;}
	
	public FacebookComment(JSONObject data){	
		super();
		this.result.data = data;
		this.id = data.getString('id');
		this.parseComment();
	}
	
	public void parseComment(){
		this.message = this.result.data.getString('message');
		this.created_time = this.result.data.getString('created_time');
		
		JSONObject.value fromv = this.result.data.getValue('from');
		if(fromv != null) {	
			this.fromId = fromv.obj.getString('id');
			this.fromName = fromv.obj.getString('name');
			this.fromCategory = fromv.obj.getString('category');
		}
	}
}