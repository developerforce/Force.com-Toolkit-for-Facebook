public class FacebookUsers {
	public List<FacebookUser> data {get;set;}
	public FacebookPaging paging {get;set;}

	public FacebookUsers(JSONParser parser) {
		while (parser.nextToken() != JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != JSONToken.VALUE_NULL) {
					if (text == 'data') {
						data = new List<FacebookUser>();
						while (parser.nextToken() != JSONToken.END_ARRAY) {
							data.add(new FacebookUser(parser));
						}
					} else if (text == 'paging') {
						paging = new FacebookPaging(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'FacebookUsers consuming unrecognized property: '+text);
						FacebookUtil.consumeObject(parser);
					}
				}
			}
		}
	}
	
	public FacebookUsers(String accessToken, String id, Map<String, String> params) {
		this(System.JSON.createParser(FacebookUtil.get(accessToken, id, params)));
	}
	
	public FacebookUsers(String accessToken, String id) {
		this(accessToken, id, null);
	}
	
	public static FacebookUsers parse(String json) {
		return new FacebookUsers(System.JSON.createParser(json));
	}
	
	public static FacebookUsers search(String accessToken, String query, Map<String, String> params) {
		if (params == null) {
			params = new Map<String, String>();
		}
		params.put('q', EncodingUtil.urlEncode(query, 'UTF-8'));
		params.put('type', 'user');
		
		return new FacebookUsers(System.JSON.createParser(FacebookUtil.get(accessToken, 'search', params)));
	}
	
	public static FacebookUsers search(String accessToken, String query) {
		return search(accessToken, query, null);
	}
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'   \"data\": ['+
		'      {'+
		'         \"name\": \"Some Text\",'+
		'         \"id\": \"1111111111\"'+
		'      },'+
		'      {'+
		'         \"name\": \"Some Text\",'+
		'         \"id\": \"1111111111\"'+
		'      }'+
		'   ],'+
		'   \"paging\": {'+
		'      \"next\": \"https://graph.facebook.com/search?q=mark&type=user&access_token=AAA&limit=25&offset=25&__after_id=757743007\"'+
		'   }'+
		'}';
		FacebookUsers r = parse(json);
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);

		FacebookUtil.testmode = true;
		FacebookUtil.teststubresponse = json;
		r = new FacebookUsers('TEST', 'TEST');
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);

		FacebookUtil.testmode = true;
		FacebookUtil.teststubresponse = json;
		r = search('TEST', 'TEST');
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		FacebookUsers objRoot = new FacebookUsers(System.JSON.createParser(json));
		System.assert(objRoot != null);
		System.assert(objRoot.data == null);
		System.assert(objRoot.paging == null);
	}
}