public class FacebookCheckin {
	public String id {get;set;}
	public FacebookRef from_z {get;set;}
	public FacebookRefs tags {get;set;}
	public FacebookPlace place {get;set;}
	public FacebookRef application {get;set;}
	public String created_time {get;set;}
	public FacebookLikes likes {get;set;}
	public String message {get;set;}

	public FacebookCheckin(JSONParser parser) {
		while (parser.nextToken() != JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != JSONToken.VALUE_NULL) {
					if (text == 'id') {
						id = parser.getText();
					} else if (text == 'from') {
						from_z = new FacebookRef(parser);
					} else if (text == 'tags') {
						tags = new FacebookRefs(parser);
					} else if (text == 'place') {
						place = new FacebookPlace(parser);
					} else if (text == 'application') {
						application = new FacebookRef(parser);
					} else if (text == 'created_time') {
						created_time = parser.getText();
					} else if (text == 'likes') {
						likes = new FacebookLikes(parser);
					} else if (text == 'message') {
						message = parser.getText();
					} else {
						System.debug(LoggingLevel.WARN, 'Checkin consuming unrecognized property: '+text);
						FacebookUtil.consumeObject(parser);
					}
				}
			}
		}
	}

	public FacebookCheckin(String accessToken, String id, Map<String, String> params) {
		this(System.JSON.createParser(FacebookUtil.get(accessToken, id, params)));
	}
	
	public FacebookCheckin(String accessToken, String id) {
		this(accessToken, id, null);
	}
	
	public static FacebookCheckin parse(String json) {
		return new FacebookCheckin(System.JSON.createParser(json));
	}
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"id\": \"10150528710678056\",'+
		'  \"from\": {'+
		'    \"name\": \"Nick Tran\",'+
		'    \"id\": \"789353055\"'+
		'  },'+
		'  \"tags\": {'+
		'    \"data\": ['+
		'      {'+
		'        \"name\": \"Dave Carroll\",'+
		'        \"id\": \"525031753\"'+
		'      },'+
		'      {'+
		'        \"name\": \"Eddy Perez\",'+
		'        \"id\": \"528441062\"'+
		'      }'+
		'    ]'+
		'  },'+
		'  \"message\": \"Heroku Meetup!\",'+
		'  \"place\": {'+
		'    \"id\": \"80950130546\",'+
		'    \"name\": \"Hacker Dojo\",'+
		'    \"location\": {'+
		'      \"street\": \"140 South Whisman Road\",'+
		'      \"city\": \"Mountain View\",'+
		'      \"state\": \"CA\",'+
		'      \"country\": \"United States\",'+
		'      \"zip\": \"94041\",'+
		'      \"latitude\": 37.386691058043,'+
		'      \"longitude\": -122.0639506415'+
		'    }'+
		'  },'+
		'  \"application\": {'+
		'    \"name\": \"Facebook for iPad\",'+
		'    \"id\": \"173847642670370\"'+
		'  },'+
		'  \"created_time\": \"2011-11-11T03:57:41+0000\",'+
		'  \"likes\": {'+
		'    \"data\": ['+
		'      {'+
		'        \"id\": \"709783833\",'+
		'        \"name\": \"Jon Mountjoy\"'+
		'      }'+
		'    ],'+
		'    \"paging\": {'+
		'      \"next\": \"https://graph.facebook.com/10150528710678056/likes?method=GET&metadata=true&format=json&callback=___GraphExplorerAsyncCallback___&access_token=AAA&limit=25&offset=25&__after_id=709783833\"'+
		'    }'+
		'  }'+
		'}';
		FacebookCheckin r = parse(json);
		System.assert(r != null);
		System.assert(r.id != null);
		System.assert(r.from_z != null);
		System.assert(r.tags != null);
		System.assert(r.place != null);
		System.assert(r.application != null);
		System.assert(r.created_time != null);
		System.assert(r.likes != null);
		System.assert(r.message != null);

		FacebookUtil.testmode = true;
		FacebookUtil.teststubresponse = json;
		r = new FacebookCheckin('TEST', 'TEST');
		System.assert(r != null);
		System.assert(r.id != null);
		System.assert(r.from_z != null);
		System.assert(r.tags != null);
		System.assert(r.place != null);
		System.assert(r.application != null);
		System.assert(r.created_time != null);
		System.assert(r.likes != null);
		System.assert(r.message != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		FacebookCheckin objData = new FacebookCheckin(System.JSON.createParser(json));
		System.assert(objData != null);
		System.assert(objData.id == null);
		System.assert(objData.from_z == null);
		System.assert(objData.tags == null);
		System.assert(objData.place == null);
		System.assert(objData.application == null);
		System.assert(objData.created_time == null);
		System.assert(objData.likes == null);
		System.assert(objData.message == null);
	}
}