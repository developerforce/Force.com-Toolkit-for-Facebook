public class FacebookLinks {
	public List<FacebookLink> data {get;set;}
	public FacebookPaging paging {get;set;}

	public FacebookLinks(JSONParser parser) {
		while (parser.nextToken() != JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != JSONToken.VALUE_NULL) {
					if (text == 'data') {
						data = new List<FacebookLink>();
						while (parser.nextToken() != JSONToken.END_ARRAY) {
							data.add(new FacebookLink(parser));
						}
					} else if (text == 'paging') {
						paging = new FacebookPaging(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'FacebookLinks consuming unrecognized property: '+text);
						FacebookUtil.consumeObject(parser);
					}
				}
			}
		}
	}
	
	public FacebookLinks(String accessToken, String id, Map<String, String> params) {
		this(System.JSON.createParser(FacebookUtil.get(accessToken, id, params)));
	}
	
	public FacebookLinks(String accessToken, String id) {
		this(accessToken, id, null);
	}
	
	public static FacebookLinks parse(String json) {
		return new FacebookLinks(System.JSON.createParser(json));
	}

	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"data\": ['+
		'    {'+
		'      \"id\": \"211575128936977\",'+
		'      \"from\": {'+
		'        \"name\": \"Pat Patterson\",'+
		'        \"id\": \"667905711\"'+
		'      },'+
		'      \"message\": \"For my non-techie friends - read this - you\'ll understand why I love working at salesforce.com.\\n\\nFor my techie friends - read this, look at salesforce.com/dreamjob and send me your résumé.\\n\\nhttp://tech.fortune.cnn.com/2012/01/19/best-companies-salesforce-benioff/\",'+
		'      \"picture\": \"https://s-external.ak.fbcdn.net/safe_image.php?d=AQBFu7k_aRukWDh_&w=90&h=90&url=http\\u00253A\\u00252F\\u00252Ffortunebrainstormtech.files.wordpress.com\\u00252F2012\\u00252F01\\u00252Fmarc_benioff_salesforce.jpg\\u00253Fw\\u00253D320\",'+
		'      \"link\": \"http://tech.fortune.cnn.com/2012/01/19/best-companies-salesforce-benioff/?source=yahoo_quote\",'+
		'      \"name\": \"Fortune Tech: Technology blogs, news and analysis from Fortune Magazine\",'+
		'      \"icon\": \"https://s-static.ak.facebook.com/rsrc.php/v1/yD/r/aS8ecmYRys0.gif\",'+
		'      \"created_time\": \"2012-01-19T15:42:00+0000\",'+
		'      \"comments\": {'+
		'        \"data\": ['+
		'          {'+
		'            \"id\": \"211575128936977_1085402\",'+
		'            \"from\": {'+
		'              \"name\": \"Joel Dietz\",'+
		'              \"id\": \"1001170\"'+
		'            },'+
		'            \"message\": \"ha ha\",'+
		'            \"can_remove\": true,'+
		'            \"created_time\": \"2012-01-19T16:16:18+0000\"'+
		'          }'+
		'        ],'+
		'        \"paging\": {'+
		'          \"next\": \"https://graph.facebook.com/211575128936977/comments?method=GET&metadata=true&format=json&callback=___GraphExplorerAsyncCallback___&access_token=AAA&limit=25&offset=25&__after_id=211575128936977_1085402\"'+
		'        }'+
		'      }'+
		'    },'+
		'    {'+
		'      \"id\": \"242847469119722\",'+
		'      \"from\": {'+
		'        \"name\": \"Pat Patterson\",'+
		'        \"id\": \"667905711\"'+
		'      },'+
		'      \"message\": \"Very cool - love the ones of buildings poking up through the fog!\",'+
		'      \"picture\": \"https://s-external.ak.fbcdn.net/safe_image.php?d=AQAi5KcVBScEsOwd&w=90&h=90&url=http\\u00253A\\u00252F\\u00252Fs3-ak.buzzfed.com\\u00252Fstatic\\u00252Fimages\\u00252Fpublic\\u00252Fspinners\\u00252Fbig_on_white.gif\",'+
		'      \"link\": \"http://www.buzzfeed.com/mjs538/100-incredible-views-out-of-airplane-windows?s=mobile\",'+
		'      \"name\": \"100 Incredible Views Out Of Airplane Windows - BuzzFeed Mobile\",'+
		'      \"description\": \"The most interesting buzz and best links.\",'+
		'      \"icon\": \"https://s-static.ak.facebook.com/rsrc.php/v1/yD/r/aS8ecmYRys0.gif\",'+
		'      \"created_time\": \"2011-12-30T05:12:32+0000\",'+
		'      \"comments\": {'+
		'        \"data\": ['+
		'          {'+
		'            \"id\": \"242847469119722_2106984\",'+
		'            \"from\": {'+
		'              \"name\": \"Tonia Maclean\",'+
		'              \"id\": \"1613439937\"'+
		'            },'+
		'            \"message\": \"Loved them....especially the salt flats!\",'+
		'            \"can_remove\": true,'+
		'            \"created_time\": \"2011-12-30T06:13:14+0000\"'+
		'          }'+
		'        ],'+
		'        \"paging\": {'+
		'          \"next\": \"https://graph.facebook.com/242847469119722/comments?method=GET&metadata=true&format=json&callback=___GraphExplorerAsyncCallback___&access_token=AAA&limit=25&offset=25&__after_id=242847469119722_2106984\"'+
		'        }'+
		'      }'+
		'    }'+
		'  ],'+
		'  \"paging\": {'+
		'    \"previous\": \"https://graph.facebook.com/me/links?format=json&limit=25&since=1326987720&__paging_token=211575128936977&__previous=1\",'+
		'    \"next\": \"https://graph.facebook.com/me/links?format=json&limit=25&until=1228882133&__paging_token=37688389791\"'+
		'  }'+
		'}';
		FacebookLinks r = parse(json);
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);

		FacebookUtil.testmode = true;
		FacebookUtil.teststubresponse = json;
		r = new FacebookLinks('TEST', 'TEST');
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		FacebookLinks objRoot = new FacebookLinks(System.JSON.createParser(json));
		System.assert(objRoot != null);
		System.assert(objRoot.data == null);
		System.assert(objRoot.paging == null);
	}
}