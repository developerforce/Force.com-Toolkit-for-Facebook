public class FacebookComments {
	public List<FacebookComment> data {get;set;}
	public FacebookPaging paging {get;set;}
	public Integer count {get;set;}

	public FacebookComments(JSONParser parser) {
		while (parser.nextToken() != JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != JSONToken.VALUE_NULL) {
					if (text == 'data') {
						data = new List<FacebookComment>();
						while (parser.nextToken() != JSONToken.END_ARRAY) {
							data.add(new FacebookComment(parser));
						}
					} else if (text == 'paging') {
						paging = new FacebookPaging(parser);
					} else if (text == 'count') {
						count = parser.getIntegerValue();
					} else {
						System.debug(LoggingLevel.WARN, 'FacebookComments consuming unrecognized property: '+text);
						FacebookUtil.consumeObject(parser);
					}
				}
			}
		}
	}
	
	public FacebookComments(String accessToken, String id, Map<String, String> params) {
		this(System.JSON.createParser(FacebookUtil.get(accessToken, id, params)));
	}
	
	public FacebookComments(String accessToken, String id) {
		this(accessToken, id, null);
	}
	
	public static FacebookComments parse(String json) {
		return new FacebookComments(System.JSON.createParser(json));
	}
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"data\": ['+
		'    {'+
		'      \"id\": \"10150146072661729_4508446\",'+
		'      \"from\": {'+
		'        \"name\": \"Nicholas Soon Joon Foon\",'+
		'        \"id\": \"725660814\"'+
		'      },'+
		'      \"message\": \"Huat ah!\",'+
		'      \"created_time\": \"2011-02-02T17:15:58+0000\"'+
		'    },'+
		'    {'+
		'      \"id\": \"10150146072661729_4508447\",'+
		'      \"from\": {'+
		'        \"name\": \"Лука Шикл\",'+
		'        \"id\": \"1719901237\"'+
		'      },'+
		'      \"message\": \"HOT DANG EXTRA\",'+
		'      \"created_time\": \"2011-02-02T17:16:00+0000\",'+
		'      \"likes\": 4'+
		'    }'+
		'  ],'+
		'  \"paging\": {'+
		'    \"next\": \"https://graph.facebook.com/10150146072661729/FacebookComments?method=GET&metadata=true&format=json&callback=___GraphExplorerAsyncCallback___&access_token=AAA&limit=25&offset=25&__after_id=10150146072661729_4508487\"'+
		'  },'+
		'  \"count\": 99'+
		'}';
		FacebookComments r = parse(json);
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);
		System.assert(r.count != null);

		FacebookUtil.testmode = true;
		FacebookUtil.teststubresponse = json;
		r = new FacebookComments('TEST', 'TEST');
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);
		System.assert(r.count != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		FacebookComments objRoot = new FacebookComments(System.JSON.createParser(json));
		System.assert(objRoot != null);
		System.assert(objRoot.data == null);
		System.assert(objRoot.paging == null);
		System.assert(objRoot.count == null);
	}
}