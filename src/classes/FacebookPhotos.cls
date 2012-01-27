public class FacebookPhotos {
	public List<FacebookPhoto> data {get;set;}
	public FacebookPaging paging {get;set;}

	public FacebookPhotos(JSONParser parser) {
		while (parser.nextToken() != JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != JSONToken.VALUE_NULL) {
					if (text == 'data') {
						data = new List<FacebookPhoto>();
						while (parser.nextToken() != JSONToken.END_ARRAY) {
							data.add(new FacebookPhoto(parser));
						}
					} else if (text == 'paging') {
						paging = new FacebookPaging(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'FacebookPhotos consuming unrecognized property: '+text);
						FacebookUtil.consumeObject(parser);
					}
				}
			}
		}
	}
	
	public FacebookPhotos(String accessToken, String id, Map<String, String> params) {
		this(System.JSON.createParser(FacebookUtil.get(accessToken, id, params)));
	}
	
	public FacebookPhotos(String accessToken, String id) {
		this(accessToken, id, null);
	}
	
	public static FacebookPhotos parse(String json) {
		return new FacebookPhotos(System.JSON.createParser(json));
	}

	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"data\": ['+
		'    {'+
		'      \"id\": \"1111111111\",'+
		'      \"from\": {'+
		'        \"name\": \"Some Text\",'+
		'        \"id\": \"1111111111\"'+
		'      },'+
		'      \"tags\": {'+
		'        \"data\": ['+
		'          {'+
		'            \"id\": \"1111111111\",'+
		'            \"name\": \"Some Text\",'+
		'            \"x\": 82,'+
		'            \"y\": 98,'+
		'            \"created_time\": \"2012-01-07T13:46:54+0000\"'+
		'          },'+
		'          {'+
		'            \"id\": \"1111111111\",'+
		'            \"name\": \"Some Text\",'+
		'            \"x\": 92,'+
		'            \"y\": 86,'+
		'            \"created_time\": \"2012-01-07T13:46:38+0000\"'+
		'          }'+
		'        ]'+
		'      },'+
		'      \"picture\": \"https://fbcdn-photos-a.akamaihd.net/\",'+
		'      \"source\": \"https://fbcdn-sphotos-a.akamaihd.net/\",'+
		'      \"height\": 537,'+
		'      \"width\": 720,'+
		'      \"images\": ['+
		'        {'+
		'          \"width\": 2048,'+
		'          \"height\": 1529,'+
		'          \"source\": \"https://fbcdn-sphotos-a.akamaihd.net/\"'+
		'        },'+
		'        {'+
		'          \"width\": 720,'+
		'          \"height\": 537,'+
		'          \"source\": \"https://fbcdn-sphotos-a.akamaihd.net/hphotos-ak-snc7/\"'+
		'        },'+
		'        {'+
		'          \"width\": 180,'+
		'          \"height\": 134,'+
		'          \"source\": \"https://fbcdn-photos-a.akamaihd.net/hphotos-ak-snc7/\"'+
		'        },'+
		'        {'+
		'          \"width\": 130,'+
		'          \"height\": 97,'+
		'          \"source\": \"https://fbcdn-photos-a.akamaihd.net/hphotos-ak-snc7/\"'+
		'        },'+
		'        {'+
		'          \"width\": 75,'+
		'          \"height\": 55,'+
		'          \"source\": \"https://fbcdn-photos-a.akamaihd.net/hphotos-ak-snc7/\"'+
		'        }'+
		'      ],'+
		'      \"link\": \"https://www.facebook.com/\",'+
		'      \"icon\": \"https://s-static.ak.facebook.com/\",'+
		'      \"created_time\": \"2012-01-07T13:46:06+0000\",'+
		'      \"position\": 9,'+
		'      \"updated_time\": \"2012-01-07T13:46:19+0000\",'+
		'      \"likes\": {'+
		'        \"data\": ['+
		'          {'+
		'            \"id\": \"1111111111\",'+
		'            \"name\": \"Some Text\"'+
		'          },'+
		'          {'+
		'            \"id\": \"1111111111\",'+
		'            \"name\": \"Some Text\"'+
		'          }'+
		'        ],'+
		'        \"paging\": {'+
		'          \"next\": \"https://graph.facebook.com/10150448133776723/likes?method=GET&metadata=true&format=json&callback=___GraphExplorerAsyncCallback___&access_token=AAA&limit=25&offset=25&__after_id=667905711\"'+
		'        }'+
		'      }'+
		'    },'+
		'    {'+
		'      \"id\": \"1111111111\",'+
		'      \"from\": {'+
		'        \"name\": \"Some Text\",'+
		'        \"id\": \"1111111111\"'+
		'      },'+
		'      \"tags\": {'+
		'        \"data\": ['+
		'          {'+
		'            \"id\": \"1111111111\",'+
		'            \"name\": \"Some Text\",'+
		'            \"x\": 22,'+
		'            \"y\": 90,'+
		'            \"created_time\": \"2012-01-07T11:22:35+0000\"'+
		'          },'+
		'          {'+
		'            \"id\": \"1111111111\",'+
		'            \"name\": \"Some Text\",'+
		'            \"x\": 90,'+
		'            \"y\": 93,'+
		'            \"created_time\": \"2012-01-07T11:23:01+0000\"'+
		'          }'+
		'        ]'+
		'      },'+
		'      \"name\": \"Some Text\",'+
		'      \"picture\": \"https://fbcdn-photos-a.akamaihd.net/\",'+
		'      \"source\": \"https://fbcdn-sphotos-a.akamaihd.net/\",'+
		'      \"height\": 404,'+
		'      \"width\": 720,'+
		'      \"images\": ['+
		'        {'+
		'          \"width\": 720,'+
		'          \"height\": 404,'+
		'          \"source\": \"https://fbcdn-sphotos-a.akamaihd.net/\"'+
		'        },'+
		'        {'+
		'          \"width\": 180,'+
		'          \"height\": 101,'+
		'          \"source\": \"https://fbcdn-photos-a.akamaihd.net/\"'+
		'        },'+
		'        {'+
		'          \"width\": 130,'+
		'          \"height\": 72,'+
		'          \"source\": \"https://fbcdn-photos-a.akamaihd.net/\"'+
		'        },'+
		'        {'+
		'          \"width\": 75,'+
		'          \"height\": 42,'+
		'          \"source\": \"https://fbcdn-photos-a.akamaihd.net/hphotos-ak-ash4/405263_10150447882971723_1048266121_t.jpg\"'+
		'        }'+
		'      ],'+
		'      \"link\": \"https://www.facebook.com/\",'+
		'      \"icon\": \"https://s-static.ak.facebook.com/\",'+
		'      \"created_time\": \"2012-01-07T09:17:11+0000\",'+
		'      \"position\": 106,'+
		'      \"updated_time\": \"2012-01-07T18:59:20+0000\",'+
		'      \"comments\": {'+
		'        \"data\": ['+
		'          {'+
		'            \"id\": \"1111111111\",'+
		'            \"from\": {'+
		'              \"name\": \"Some Text\",'+
		'              \"id\": \"1111111111\"'+
		'            },'+
		'            \"message\": \"Some Text\",'+
		'            \"can_remove\": true,'+
		'            \"created_time\": \"2012-01-07T10:27:48+0000\",'+
		'            \"likes\": 1'+
		'          },'+
		'          {'+
		'            \"id\": \"1111111111\",'+
		'            \"from\": {'+
		'              \"name\": \"Some Text\",'+
		'              \"id\": \"1111111111\"'+
		'            },'+
		'            \"message\": \"Some Text\",'+
		'            \"created_time\": \"2012-01-07T11:11:28+0000\",'+
		'            \"likes\": 2'+
		'          }'+
		'        ],'+
		'        \"paging\": {'+
		'          \"next\": \"https://graph.facebook.com/10150447882971723/comments?method=GET&metadata=true&format=json&callback=___GraphExplorerAsyncCallback___&access_token=AAA&limit=25&offset=25&__after_id=10150447882971723_5474181\"'+
		'        }'+
		'      }'+
		'    }'+
		'  ],'+
		'  \"paging\": {'+
		'    \"previous\": \"https://graph.facebook.com/me/photos?format=json&limit=25&since=1325943966&__previous=1\",'+
		'    \"next\": \"https://graph.facebook.com/me/photos?format=json&limit=25&until=1274146932\"'+
		'  }'+
		'}';
		FacebookPhotos r = parse(json);
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);

		FacebookUtil.testmode = true;
		FacebookUtil.teststubresponse = json;
		r = new FacebookPhotos('TEST', 'TEST');
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		FacebookPhotos objRoot = new FacebookPhotos(System.JSON.createParser(json));
		System.assert(objRoot != null);
		System.assert(objRoot.data == null);
		System.assert(objRoot.paging == null);
	}
}