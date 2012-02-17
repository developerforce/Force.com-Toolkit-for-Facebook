public class FacebookRefs {
	public List<FacebookRef> data {get;set;}
	public FacebookPaging paging {get;set;}

	public FacebookRefs(JSONParser parser) {
		while (parser.nextToken() != JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != JSONToken.VALUE_NULL) {
					if (text == 'data') {
						data = new List<FacebookRef>();
						while (parser.nextToken() != JSONToken.END_ARRAY) {
							data.add(new FacebookRef(parser));
						}
					} else if (text == 'paging') {
						paging = new FacebookPaging(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'FacebookRefs consuming unrecognized property: '+text);
						FacebookUtil.consumeObject(parser);
					}
				}
			}
		}
	}

	public FacebookRefs(String accessToken, String id, Map<String, String> params) {
		this(System.JSON.createParser(FacebookUtil.get(accessToken, id, params)));
	}
	
	public FacebookRefs(String accessToken, String id) {
		this(accessToken, id, null);
	}
	
	public static FacebookRefs parse(String json) {
		return new FacebookRefs(System.JSON.createParser(json));
	}

	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"data\": ['+
		'    {'+
		'      \"name\": \"Metallica - August 31, 2011 Moscone Center, San Francisco, CA\",'+
		'      \"category\": \"Album\",'+
		'      \"id\": \"108795549226460\",'+
		'      \"created_time\": \"2011-09-07T21:11:43+0000\"'+
		'    },'+
		'    {'+
		'      \"name\": \"Amy Winehouse\",'+
		'      \"category\": \"Musician/band\",'+
		'      \"id\": \"7310480740\",'+
		'      \"created_time\": \"2011-07-23T17:14:07+0000\"'+
		'    }'+
		'  ],'+
		'  \"paging\": {'+
		'    \"next\": \"https://graph.facebook.com/me/music?format=json&limit=5000&offset=5000&__after_id=12577662367\"'+
		'  }'+
		'}';
		FacebookRefs r = parse(json);
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);

		FacebookUtil.testmode = true;
		FacebookUtil.teststubresponse = json;
		r = new FacebookRefs('TEST', 'TEST');
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		FacebookRefs objRoot = new FacebookRefs(System.JSON.createParser(json));
		System.assert(objRoot != null);
		System.assert(objRoot.data == null);
		System.assert(objRoot.paging == null);
	}
}