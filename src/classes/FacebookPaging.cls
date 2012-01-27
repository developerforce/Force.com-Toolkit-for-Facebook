public class FacebookPaging {
	public String previous {get;set;}
	public String next {get;set;}

	public FacebookPaging(JSONParser parser) {
		while (parser.nextToken() != JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != JSONToken.VALUE_NULL) {
					if (text == 'previous') {
						previous = parser.getText();
					} else if (text == 'next') {
						next = parser.getText();
					} else {
						System.debug(LoggingLevel.WARN, 'Paging consuming unrecognized property: '+text);
						FacebookUtil.consumeObject(parser);
					}
				}
			}
		}
	}
	
	public FacebookPaging(String accessToken, String id, Map<String, String> params) {
		this(System.JSON.createParser(FacebookUtil.get(accessToken, id, params)));
	}
	
	public FacebookPaging(String accessToken, String id) {
		this(accessToken, id, null);
	}
	
	public static FacebookPaging parse(String json) {
		return new FacebookPaging(System.JSON.createParser(json));
	}
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"previous\": \"https://graph.facebook.com/me/albums?format=json&limit=25&since=1326640001&__paging_token=10150602463220712&__previous=1\",'+
		'  \"next\": \"https://graph.facebook.com/me/albums?format=json&limit=25&until=1216004257&__paging_token=27800405711\"'+
		'}';
		FacebookPaging r = parse(json);
		System.assert(r != null);
		System.assert(r.previous != null);
		System.assert(r.next != null);

		FacebookUtil.testmode = true;
		FacebookUtil.teststubresponse = json;
		r = new FacebookPaging('TEST', 'TEST');
		System.assert(r != null);
		System.assert(r.previous != null);
		System.assert(r.next != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		FacebookPaging objPaging = new FacebookPaging(System.JSON.createParser(json));
		System.assert(objPaging != null);
		System.assert(objPaging.previous == null);
		System.assert(objPaging.next == null);
	}
}