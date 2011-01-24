/**
 * @author Quinton Wall - qwall@salesforce.com
 * @author Gastón Esmela - gesmela@salesforce.com
 */

public class FacebookEvent extends FacebookObject {	
	public String id {get;set;}
	public String name {get;set;}
	public String ownerId {get;set;}
	public String ownerName {get;set;}
	public String location {get;set;}
	public String description {get;set;}
	public String venueStreet {get;set;}
	public String venueCity {get;set;}
	public String venueState {get;set;}
	public String venueZip {get;set;}
	public String venueCountry {get;set;}
	public String venueLatitude {get;set;}
	public String venueLongitude {get;set;}
	public String privacy {get;set;}
	public String start_time {get;set;}
	public String end_time {get;set;}
	
	/**
	 * Constructor
	 */
	public FacebookEvent(String id){	
		super();
		this.id = id;
	}
	public FacebookEvent(JSONObject data){	
		super();
		this.result.data = data;
		this.id = data.getString('id');
		this.parseEvent();
	}
		
	/**
	 * JSON Parsing.
	 */
	public void parseEvent(){
		this.name = this.result.data.getString('name');
		this.description = this.result.data.getString('description');
		this.location = this.result.data.getString('location');
		this.privacy = this.result.data.getString('privacy');
		
		this.start_time = this.result.data.getString('start_time');
		this.end_time = this.result.data.getString('end_time');
		
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