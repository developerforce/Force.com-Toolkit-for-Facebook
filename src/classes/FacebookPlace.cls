public class FacebookPlace {
	public class Location {
		public String street {get;set;}
		public String city {get;set;}
		public String state {get;set;}
		public String country {get;set;}
		public String zip {get;set;}
		public Double latitude {get;set;}
		public Double longitude {get;set;}

		public Location(JSONParser parser) {
			while (parser.nextToken() != JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != JSONToken.VALUE_NULL) {
						if (text == 'street') {
							street = parser.getText();
						} else if (text == 'city') {
							city = parser.getText();
						} else if (text == 'state') {
							state = parser.getText();
						} else if (text == 'country') {
							country = parser.getText();
						} else if (text == 'zip') {
							zip = parser.getText();
						} else if (text == 'latitude') {
							latitude = parser.getDoubleValue();
						} else if (text == 'longitude') {
							longitude = parser.getDoubleValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Location consuming unrecognized property: '+text);
							FacebookUtil.consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public String name {get;set;}
	public String category {get;set;}
	public Location location {get;set;}
	public String id {get;set;}

	public FacebookPlace(JSONParser parser) {
		while (parser.nextToken() != JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != JSONToken.VALUE_NULL) {
					if (text == 'name') {
						name = parser.getText();
					} else if (text == 'category') {
						category = parser.getText();
					} else if (text == 'location') {
						location = new Location(parser);
					} else if (text == 'id') {
						id = parser.getText();
					} else {
						System.debug(LoggingLevel.WARN, 'FacebookPlace consuming unrecognized property: '+text);
						FacebookUtil.consumeObject(parser);
					}
				}
			}
		}
	}
	
	public FacebookPlace(String accessToken, String id, Map<String, String> params) {
		this(System.JSON.createParser(FacebookUtil.get(accessToken, id, params)));
	}
	
	public FacebookPlace(String accessToken, String id) {
		this(accessToken, id, null);
	}
	
	public static FacebookPlace parse(String json) {
		return new FacebookPlace(System.JSON.createParser(json));
	}
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"name\": \"Philz Coffee\",'+
		'  \"category\": \"Local business\",'+
		'  \"location\": {'+
		'     \"street\": \"4023 18th St\",'+
		'     \"city\": \"San Francisco\",'+
		'     \"state\": \"CA\",'+
		'     \"country\": \"United States\",'+
		'     \"zip\": \"94114-2501\",'+
		'     \"latitude\": 37.760876096373,'+
		'     \"longitude\": -122.43272191478'+
		'  },'+
		'  \"id\": \"151116474914629\"'+
		'}';
		FacebookPlace r = parse(json);
		System.assert(r != null);
		System.assert(r.name != null);
		System.assert(r.category != null);
		System.assert(r.location != null);
		System.assert(r.id != null);

		FacebookUtil.testmode = true;
		FacebookUtil.teststubresponse = json;
		r = new FacebookPlace('TEST', 'TEST');
		System.assert(r != null);
		System.assert(r.name != null);
		System.assert(r.category != null);
		System.assert(r.location != null);
		System.assert(r.id != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		FacebookPlace objPlace = new FacebookPlace(System.JSON.createParser(json));
		System.assert(objPlace != null);
		System.assert(objPlace.name == null);
		System.assert(objPlace.category == null);
		System.assert(objPlace.location == null);
		System.assert(objPlace.id == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		Location objLocation = new Location(System.JSON.createParser(json));
		System.assert(objLocation != null);
		System.assert(objLocation.street == null);
		System.assert(objLocation.city == null);
		System.assert(objLocation.state == null);
		System.assert(objLocation.country == null);
		System.assert(objLocation.zip == null);
		System.assert(objLocation.latitude == null);
		System.assert(objLocation.longitude == null);
	}
}