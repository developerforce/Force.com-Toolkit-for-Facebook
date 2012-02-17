public class FacebookEvents {
	public List<FacebookEvent> data {get;set;}
	public FacebookPaging paging {get;set;}

	public FacebookEvents(JSONParser parser) {
		while (parser.nextToken() != JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != JSONToken.VALUE_NULL) {
					if (text == 'data') {
						data = new List<FacebookEvent>();
						while (parser.nextToken() != JSONToken.END_ARRAY) {
							data.add(new FacebookEvent(parser));
						}
					} else if (text == 'paging') {
						paging = new FacebookPaging(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'FacebookEvents consuming unrecognized property: '+text);
						FacebookUtil.consumeObject(parser);
					}
				}
			}
		}
	}
	
	public FacebookEvents(String accessToken, String id, Map<String, String> params) {
		this(System.JSON.createParser(FacebookUtil.get(accessToken, id, params)));
	}
	
	public FacebookEvents(String accessToken, String id) {
		this(accessToken, id, null);
	}
	
	public static FacebookEvents parse(String json) {
		return new FacebookEvents(System.JSON.createParser(json));
	}
	
	public static FacebookEvents search(String accessToken, String query, Map<String, String> params) {
		if (params == null) {
			params = new Map<String, String>();
		}
		params.put('q', EncodingUtil.urlEncode(query, 'UTF-8'));
		params.put('type', 'event');
		
		return new FacebookEvents(System.JSON.createParser(FacebookUtil.get(accessToken, 'search', params)));
	}
	
	public static FacebookEvents search(String accessToken, String query) {
		return search(accessToken, query, null);
	}
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"data\": ['+
		'    {'+
		'      \"id\": \"331218348435\",'+
		'      \"owner\": {'+
		'        \"name\": \"Julia Lam\",'+
		'        \"id\": \"2503747\"'+
		'      },'+
		'      \"name\": \"Facebook Developer Garage Austin - SXSW Edition\",'+
		'      \"description\": \"Join the Facebook team and local developers for a deep dive into the latest and most exciting ways developers are building with Facebook technologies. \\n\\nCome to learn, stay to make friends!\\n\\nTentative Agenda:\\n2:00 - 2:30 PM - Registration\\n2:30 - 3:30 PM - Learn the latest from Facebook and local developers\\n3:30 - 5:30 PM - Drink with friends! Stay and mingle with your developer community.\\n\\n*Come early! Drink tickets and t-shirts provided to the first 300 attendees. Cash bar provided for all attendees.\\n\\nTopics & Speakers:\\n--Multi-Platform Social Games (Gareth Davis, Facebook) \\n--Increasing Mobile Engagement with Facebook Connect (Josh Williams, Gowalla)\\n--Facebook Integration with Seesmic (or How to Build Community Using Octopus Balls...) (John Yamasaki, Seesmic)\\n--Going multi-platform: the brave new world beyond facebook.com (Sebastien de Halleux, Playfish / EA Interactive)\\n--Socially Connected Exploding Gems Everywhere...Excellent! (Jon David, PopCap Games)\\n\\n* Emceed by Austin local: whurley, Chaotic Moon Studios\\n* All are welcome to attend, no badge is required.\\n* If you can\'t make it in person, you can join the live stream, beginning at 2:00 PM CST, here: http://ustream.tv/fbplatform \\n\\n***DAYLIGHT SAVINGS STARTS SUNDAY AT 2 AM, PLEASE ADJUST YOUR CLOCKS ACCORDINGLY***\",'+
		'      \"start_time\": \"2010-03-14T14:00:00\",'+
		'      \"end_time\": \"2010-03-14T17:30:00\",'+
		'      \"location\": \"The Phoenix\",'+
		'      \"venue\": {'+
		'        \"street\": \"409 Colorado St.\",'+
		'        \"city\": \"Austin\",'+
		'        \"state\": \"Texas\",'+
		'        \"country\": \"United States\"'+
		'      },'+
		'      \"privacy\": \"OPEN\",'+
		'      \"updated_time\": \"2010-04-13T15:29:40+0000\",'+
		'      \"rsvp_status\": \"unsure\",'+
		'      \"type\": \"event\"'+
		'    }'+
		'  ],'+
		'  \"paging\": {'+
		'    \"next\": \"https://graph.facebook.com/10150146072661729/FacebookComments?method=GET&metadata=true&format=json&callback=___GraphExplorerAsyncCallback___&access_token=AAA&limit=25&offset=25&__after_id=10150146072661729_4508487\"'+
		'  }'+
		'}';
		FacebookEvents r = parse(json);
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);

		FacebookUtil.testmode = true;
		FacebookUtil.teststubresponse = json;
		r = new FacebookEvents('TEST', 'TEST');
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);

		r = search('TEST', 'TEST');
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		FacebookEvents objRoot = new FacebookEvents(System.JSON.createParser(json));
		System.assert(objRoot != null);
		System.assert(objRoot.data == null);
		System.assert(objRoot.paging == null);
	}
}