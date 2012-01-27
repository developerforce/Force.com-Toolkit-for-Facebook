public class FacebookRef {
	public String name {get;set;}
	public String id {get;set;}
	public String category {get;set;}
	public String canvas_name {get;set;}
	public String namespace {get;set;}
	public String created_time {get;set;}

	public FacebookRef(JSONParser parser) {
		while (parser.nextToken() != JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != JSONToken.VALUE_NULL) {
					if (text == 'name') {
						name = parser.getText();
					} else if (text == 'id') {
						id = parser.getText();
					} else if (text == 'category') {
						category = parser.getText();
					} else if (text == 'canvas_name') {
						canvas_name = parser.getText();
					} else if (text == 'namespace') {
						namespace = parser.getText();
					} else if (text == 'created_time') {
						created_time = parser.getText();
					} else {
						System.debug(LoggingLevel.WARN, 'FacebookRef consuming unrecognized property: '+text);
						FacebookUtil.consumeObject(parser);
					}
				}
			}
		}
	}

	public FacebookRef(String accessToken, String id, Map<String, String> params) {
		this(System.JSON.createParser(FacebookUtil.get(accessToken, id, params)));
	}
	
	public FacebookRef(String accessToken, String id) {
		this(accessToken, id, null);
	}
	
	public static FacebookRef parse(String json) {
		return new FacebookRef(System.JSON.createParser(json));
	}
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"id\": \"667905711\",'+
		'  \"name\": \"Pat Patterson\",'+
		'  \"category\": \"Some Text\",'+
		'  \"canvas_name\": \"Some Text\",'+
		'  \"namespace\": \"Some Text\",'+
		'  \"created_time\": \"2011-05-10T18:35:38+0000\"'+
		'}';
		
		FacebookRef r = parse(json);
		System.assert(r != null);
		System.assert(r.id != null);
		System.assert(r.name != null);
		System.assert(r.category != null);
		System.assert(r.canvas_name != null);
		System.assert(r.namespace != null);
		System.assert(r.created_time != null);
	
		FacebookUtil.testmode = true;
		FacebookUtil.teststubresponse = json;
		r = new FacebookRef('TEST', 'TEST');
		System.assert(r != null);
		System.assert(r.id != null);
		System.assert(r.name != null);
		System.assert(r.category != null);
		System.assert(r.canvas_name != null);
		System.assert(r.namespace != null);
		System.assert(r.created_time != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		FacebookRef objRoot = new FacebookRef(System.JSON.createParser(json));
		System.assert(objRoot != null);
		System.assert(objRoot.id == null);
		System.assert(objRoot.name == null);
		System.assert(objRoot.category == null);
		System.assert(objRoot.canvas_name == null);
		System.assert(objRoot.namespace == null);
		System.assert(objRoot.created_time == null);
	}
}