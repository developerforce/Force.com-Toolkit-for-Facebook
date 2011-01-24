/**
 * @author Quinton Wall - qwall@salesforce.com
 * @author Gastón Esmela - gesmela@salesforce.com
 */

public class FacebookGroup extends FacebookObject {	
	public String id {get;set;}
	public String name {get;set;}
	public String ownerId {get;set;}
	public String ownerName {get;set;}
	public String description {get;set;}
	public String venueStreet {get;set;}
	public String venueCity {get;set;}
	public String venueState {get;set;}
	public String venueZip {get;set;}
	public String venueCountry {get;set;}
	public String venueLatitude {get;set;}
	public String venueLongitude {get;set;}
	public String privacy {get;set;}
	public String updated_time {get;set;}
	
	/**
	 * Constructor
	 */
	public FacebookGroup(String id){	
		super();
		this.id = id;
	}
	public FacebookGroup(JSONObject data){	
		super();
		this.result.data = data;
		this.id = data.getString('id');
		this.parseGroup();
	}
		
	/**
	 * JSON Parsing.
	 */
	public void parseGroup(){
		this.name = this.result.data.getString('name');
		this.description = this.result.data.getString('description');
		this.privacy = this.result.data.getString('privacy');
		this.updated_time = this.result.data.getString('updated_time');
		
		JSONObject.value ownerV = this.result.data.getValue('owner');
		if(ownerV != null){	
			this.ownerId = ownerV.obj.getString('id');
			this.ownerName = ownerV.obj.getString('name');
		}
		
		JSONObject.value venueValue = this.result.data.getValue('venue');
		if(venueValue != null) {	
			this.venueStreet = venueValue.obj.getString('street');
			this.venueCity = venueValue.obj.getString('city');
			this.venueState = venueValue.obj.getString('state');
			this.venueZip = venueValue.obj.getString('zip');
			this.venueCountry = venueValue.obj.getString('country');
			this.venueLatitude = venueValue.obj.getString('latitude');
			this.venueLongitude = venueValue.obj.getString('longitude');
		}
	}
}