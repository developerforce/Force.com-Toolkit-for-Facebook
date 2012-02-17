public class FacebookLikes {
	public List<FacebookRef> data {get;set;}
	public FacebookPaging paging {get;set;}
	public Integer count {get;set;}

	public FacebookLikes(JSONParser parser) {
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
					} else if (text == 'count') {
						count = parser.getIntegerValue();
					} else {
						System.debug(LoggingLevel.WARN, 'FacebookLikes consuming unrecognized property: '+text);
						FacebookUtil.consumeObject(parser);
					}
				}
			}
		}
	}

	public FacebookLikes(String accessToken, String id, Map<String, String> params) {
		this(System.JSON.createParser(FacebookUtil.get(accessToken, id, params)));
	}
	
	public FacebookLikes(String accessToken, String id) {
		this(accessToken, id, null);
	}
	
	public static FacebookLikes parse(String json) {
		return new FacebookLikes(System.JSON.createParser(json));
	}
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"data\": ['+
		'    {'+
		'      \"id\": \"100003041584765\",'+
		'      \"name\": \"Ar-raniry Muhammad\"'+
		'    },'+
		'    {'+
		'      \"id\": \"100001003048497\",'+
		'      \"name\": \"Khairil Seven Freaks\"'+
		'    }'+
		'  ],'+
		'  \"paging\": {'+
		'    \"next\": \"https://graph.facebook.com/10150224661566729/likes?method=GET&metadata=true&format=json&callback=___GraphExplorerAsyncCallback___&access_token=AAA&limit=25&offset=25&__after_id=100002227510322\"'+
		'  }'+
		'}';
		FacebookLikes r = parse(json);
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);
		System.assert(r.paging != null);
		
		FacebookUtil.testmode = true;
		FacebookUtil.teststubresponse = json;
		r = new FacebookLikes('TEST', 'TEST');
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);
		System.assert(r.paging != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		FacebookLikes objLikes = new FacebookLikes(System.JSON.createParser(json));
		System.assert(objLikes != null);
		System.assert(objLikes.data == null);
		System.assert(objLikes.paging == null);
		System.assert(objLikes.count == null);
	}
}