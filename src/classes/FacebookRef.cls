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
						namespace = parser.getText();
					} else {
						System.debug(LoggingLevel.WARN, 'FacebookRef consuming unrecognized property: '+text);
						FacebookUtil.consumeObject(parser);
					}
				}
			}
		}
	}

	public static FacebookRef parse(String json) {
		return new FacebookRef(System.JSON.createParser(json));
	}
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"id\": \"667905711\",'+
		'  \"name\": \"Pat Patterson\"'+
		'}';
		
		FacebookRef r = parse(json);
		System.assert(r != null);
	
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