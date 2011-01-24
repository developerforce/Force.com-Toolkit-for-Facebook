/**
 * @author Quinton Wall - qwall@salesforce.com
 * @author Gastón Esmela - gesmela@salesforce.com
 */

public class FacebookPage extends FacebookObject {

	public String id {get;set;}
	public String name {get;set;}
	public Long fan_count {get;set;}
	public String picture {get;set;}
	public String category {get;set;}
	
	/**
	 * Constructor
	 */
	public FacebookPage(String id){	
		super();
		this.id = id;
	}
	public FacebookPage(JSONObject data){	
		super();
		this.result.data = data;
		this.id = data.getString('id');
		this.parsePage();
	}
	
	
	/**
	 * JSON Parsing.
	 */
	public void parsePage(){
		this.name = this.result.data.getString('name');
		this.category = this.result.data.getString('category');
		this.picture = this.result.data.getString('picture');
		if(this.result.data.getValue('fan_count') != null)
			this.fan_count = this.result.data.getValue('fan_count').dnum.longValue();
	}
}