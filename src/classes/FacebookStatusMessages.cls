public class FacebookStatusMessages {
	public List<FacebookStatusMessage> data {get;set;}
	public FacebookPaging paging {get;set;}

	public FacebookStatusMessages(JSONParser parser) {
		while (parser.nextToken() != JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != JSONToken.VALUE_NULL) {
					if (text == 'data') {
						data = new List<FacebookStatusMessage>();
						while (parser.nextToken() != JSONToken.END_ARRAY) {
							data.add(new FacebookStatusMessage(parser));
						}
					} else if (text == 'paging') {
						paging = new FacebookPaging(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'FacebookStatusMessages consuming unrecognized property: '+text);
						FacebookUtil.consumeObject(parser);
					}
				}
			}
		}
	}
	
	public FacebookStatusMessages(String accessToken, String id, Map<String, String> params) {
		this(System.JSON.createParser(FacebookUtil.get(accessToken, id, params)));
	}
	
	public FacebookStatusMessages(String accessToken, String id) {
		this(accessToken, id, null);
	}
	
	public static FacebookStatusMessages parse(String json) {
		return new FacebookStatusMessages(System.JSON.createParser(json));
	}

	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"data\": ['+
		'    {'+
		'      \"id\": \"10150623902980712\",'+
		'      \"from\": {'+
		'        \"name\": \"Pat Patterson\",'+
		'        \"id\": \"667905711\"'+
		'      },'+
		'      \"message\": \"test\",'+
		'      \"updated_time\": \"2012-01-24T08:21:30+0000\",'+
		'      \"comments\": {'+
		'        \"data\": ['+
		'          {'+
		'            \"id\": \"10150623902980712_22181111\",'+
		'            \"from\": {'+
		'              \"name\": \"Keith Burns\",'+
		'              \"id\": \"531654098\"'+
		'            },'+
		'            \"message\": \"ack?\",'+
		'            \"can_remove\": true,'+
		'            \"created_time\": \"2012-01-24T13:54:48+0000\"'+
		'          }'+
		'        ],'+
		'        \"paging\": {'+
		'          \"next\": \"https://graph.facebook.com/10150623902980712/comments?method=GET&metadata=true&format=json&callback=___GraphExplorerAsyncCallback___&access_token=AAA&limit=25&offset=25&__after_id=10150623902980712_22181111\"'+
		'        }'+
		'      }'+
		'    },'+
		'    {'+
		'      \"id\": \"10150622788265712\",'+
		'      \"from\": {'+
		'        \"name\": \"Pat Patterson\",'+
		'        \"id\": \"667905711\"'+
		'      },'+
		'      \"message\": \"I like to test\",'+
		'      \"updated_time\": \"2012-01-23T22:14:40+0000\",'+
		'      \"comments\": {'+
		'        \"data\": ['+
		'          {'+
		'            \"id\": \"10150622788265712_22169464\",'+
		'            \"from\": {'+
		'              \"name\": \"Brian Campbell\",'+
		'              \"id\": \"1296855662\"'+
		'            },'+
		'            \"message\": \"seems to be working\",'+
		'            \"can_remove\": true,'+
		'            \"created_time\": \"2012-01-23T22:36:40+0000\"'+
		'          },'+
		'          {'+
		'            \"id\": \"10150622788265712_22169898\",'+
		'            \"from\": {'+
		'              \"name\": \"Keith Burns\",'+
		'              \"id\": \"531654098\"'+
		'            },'+
		'            \"message\": \"˙ɯǝlqoɹd ɟo ʇɹos ǝɯos ǝq oʇ sɯǝǝS\",'+
		'            \"can_remove\": true,'+
		'            \"created_time\": \"2012-01-23T23:03:20+0000\",'+
		'            \"likes\": 1'+
		'          },'+
		'          {'+
		'            \"id\": \"10150622788265712_22169951\",'+
		'            \"from\": {'+
		'              \"name\": \"Pat Patterson\",'+
		'              \"id\": \"667905711\"'+
		'            },'+
		'            \"message\": \"I can post ok, but delete isn\'t working... Yet.\",'+
		'            \"can_remove\": true,'+
		'            \"created_time\": \"2012-01-23T23:07:34+0000\"'+
		'          },'+
		'          {'+
		'            \"id\": \"10150622788265712_22171111\",'+
		'            \"from\": {'+
		'              \"name\": \"Wayne Young\",'+
		'              \"id\": \"1470540731\"'+
		'            },'+
		'            \"message\": \"That\'s What GLaDOS said, right before she told me the cake was a lie ..\",'+
		'            \"can_remove\": true,'+
		'            \"created_time\": \"2012-01-24T00:32:11+0000\"'+
		'          }'+
		'        ],'+
		'        \"paging\": {'+
		'          \"next\": \"https://graph.facebook.com/10150622788265712/comments?method=GET&metadata=true&format=json&callback=___GraphExplorerAsyncCallback___&access_token=AAA&limit=25&offset=25&__after_id=10150622788265712_22171111\"'+
		'        }'+
		'      }'+
		'    }'+
		'  ],'+
		'  \"paging\": {'+
		'    \"previous\": \"https://graph.facebook.com/me/statuses?format=json&limit=25&since=1327393290&__paging_token=10150623902980712&__previous=1\",'+
		'    \"next\": \"https://graph.facebook.com/me/statuses?format=json&limit=25&until=1271741833&__paging_token=119634478053711\"'+
		'  }'+
		'}';
		FacebookStatusMessages r = parse(json);
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);

		FacebookUtil.testmode = true;
		FacebookUtil.teststubresponse = json;
		r = new FacebookStatusMessages('TEST', 'TEST');
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		FacebookStatusMessages objRoot = new FacebookStatusMessages(System.JSON.createParser(json));
		System.assert(objRoot != null);
		System.assert(objRoot.data == null);
		System.assert(objRoot.paging == null);
	}
}