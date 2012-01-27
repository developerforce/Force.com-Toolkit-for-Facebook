public class FacebookComment {
	public String id {get;set;}
	public FacebookRef from_z {get;set;}
	public String message {get;set;}
	public String created_time {get;set;}
	public Integer likes {get;set;}
	public String user_likes {get;set;}
	public Boolean can_remove {get;set;}
	public String type {get;set;}

	public FacebookComment(JSONParser parser) {
		while (parser.nextToken() != JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != JSONToken.VALUE_NULL) {
					if (text == 'id') {
						id = parser.getText();
					} else if (text == 'from') {
						from_z = new FacebookRef(parser);
					} else if (text == 'message') {
						message = parser.getText();
					} else if (text == 'created_time') {
						created_time = parser.getText();
					} else if (text == 'likes') {
						likes = parser.getIntegerValue();
					} else if (text == 'user_likes') {
						user_likes = parser.getText();
					} else if (text == 'type') {
						type = parser.getText();
						if (!type.equals('comment')) {
							throw new FacebookException('FacebookComment found object type '+type+' - expected comment');
						}
					} else {
						System.debug(LoggingLevel.WARN, 'FacebookComment consuming unrecognized property: '+text);
						FacebookUtil.consumeObject(parser);
					}
				} 
			}
		}
	}
	
	public FacebookComment(String accessToken, String id, Map<String, String> params) {
		this(System.JSON.createParser(FacebookUtil.get(accessToken, id, params)));
	}
	
	public FacebookComment(String accessToken, String id) {
		this(accessToken, id, null);
	}
	
	public static FacebookComment parse(String json) {
		return new FacebookComment(System.JSON.createParser(json));
	}
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"id\": \"2031763147233_1791429\",'+
		'  \"from\": {'+
		'    \"name\": \"Robin Rin Parkinson\",'+
		'    \"id\": \"100000474815248\"'+
		'  },'+
		'  \"message\": \"AAH SCARY DOG#\",'+
		'  \"created_time\": \"2011-07-06T17:30:44+0000\",'+
		'  \"likes\": 5,'+
		'  \"user_likes\": \"true\",'+
		'  \"type\": \"comment\"'+
		'}';
		FacebookComment r = parse(json);
		System.assert(r != null);
		System.assert(r.id != null);
		System.assert(r.from_z != null);
		System.assert(r.message != null);
		System.assert(r.created_time != null);
		System.assert(r.likes != null);
		System.assert(r.user_likes != null);
		System.assert(r.type != null);

		FacebookUtil.testmode = true;
		FacebookUtil.teststubresponse = json;
		r = new FacebookComment('TEST', 'TEST');
		System.assert(r != null);
		System.assert(r.id != null);
		System.assert(r.from_z != null);
		System.assert(r.message != null);
		System.assert(r.created_time != null);
		System.assert(r.likes != null);
		System.assert(r.user_likes != null);
		System.assert(r.type != null);

		json = '{\"type\": \"test\" }';
		try {
			FacebookComment objRoot = new FacebookComment(System.JSON.createParser(json));
			System.assert(false);
		} catch (FacebookException fbe) {
			System.assertEquals(fbe.getMessage(), 'FacebookComment found object type test - expected comment');
		}

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		FacebookComment objRoot = new FacebookComment(System.JSON.createParser(json));
		System.assert(objRoot != null);
		System.assert(objRoot.id == null);
		System.assert(objRoot.from_z == null);
		System.assert(objRoot.message == null);
		System.assert(objRoot.created_time == null);
		System.assert(objRoot.likes == null);
		System.assert(objRoot.user_likes == null);
		System.assert(objRoot.type == null);
	}
}