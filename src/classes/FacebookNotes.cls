public class FacebookNotes {
	public List<FacebookNote> data {get;set;}
	public FacebookPaging paging {get;set;}

	public FacebookNotes(JSONParser parser) {
		while (parser.nextToken() != JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != JSONToken.VALUE_NULL) {
					if (text == 'data') {
						data = new List<FacebookNote>();
						while (parser.nextToken() != JSONToken.END_ARRAY) {
							data.add(new FacebookNote(parser));
						}
					} else if (text == 'paging') {
						paging = new FacebookPaging(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'FacebookNotes consuming unrecognized property: '+text);
						FacebookUtil.consumeObject(parser);
					}
				}
			}
		}
	}
	
	public FacebookNotes(String accessToken, String id, Map<String, String> params) {
		this(System.JSON.createParser(FacebookUtil.get(accessToken, id, params)));
	}
	
	public FacebookNotes(String accessToken, String id) {
		this(accessToken, id, null);
	}
	
	public static FacebookNotes parse(String json) {
		return new FacebookNotes(System.JSON.createParser(json));
	}

	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"data\": ['+
		'    {'+
		'      \"id\": \"170173942109\",'+
		'      \"from\": {'+
		'        \"name\": \"Pat Patterson\",'+
		'        \"id\": \"667905711\"'+
		'      },'+
		'      \"subject\": \"My Life According To The Jam\",'+
		'      \"message\": \"<div><p>Using only song names from ONE ARTIST, cleverly (or not) answer these questions. Pass it on to 12 people you like and include me. You can&#039;t use the band I used. Try not to repeat a song title. It&#039;s a lot harder than you think! Repost as &quot;my life according to (band name)&quot;<br /><br />______________________________________________<br /><br />Are you a male or female:<br />Little Boy Soldiers<br /><br />Describe yourself:<br />Boy About Town<br /><br />How do you feel:<br />Pretty Green <br /><br />Describe where you currently live:<br />The Place I Love<br /><br />If you could go anywhere, where would you go:<br />In The City<br /><br />Your favourite form of transportation:<br />Trans-Global Express<br /><br />Your best friend is:<br />English Rose<br /><br />You and your best friend are:<br />Thick as Thieves<br /><br />What&#039;s the weather like:<br />Burning Sky<br /><br />Favourite time of day:<br />Tonight at Noon<br /><br />If your life was a TV show, what would it be called:<br />Tales from the Riverbank<br /><br />What is life to you:<br />All Mod Cons<br /><br />Your current relationship:<br />(Love Is Like A) Heat Wave <br /><br />Your fear:<br />&#039;A&#039; Bomb in Wardour Street<br /><br />What is the best advice you have to give:<br />Don&#039;t Tell Them You&#039;re Sane<br /><br />Thought for the Day:<br />Just Who Is the 5 O&#039;Clock Hero?<br /><br />How I would like to die:<br />Stoned Out of My Mind<br /><br />My soul&#039;s present condition:<br />Precious<br /><br />My motto:<br />Move On Up</p></div>\",'+
		'      \"icon\": \"https://s-static.ak.facebook.com/rsrc.php/v1/yY/r/1gBp2bDGEuh.gif\",'+
		'      \"created_time\": \"2009-09-28T05:22:11+0000\",'+
		'      \"updated_time\": \"2009-09-28T05:22:11+0000\",'+
		'      \"comments\": {'+
		'        \"data\": ['+
		'          {'+
		'            \"id\": \"170173942109_5369096\",'+
		'            \"from\": {'+
		'              \"name\": \"Richard O\'Hagan\",'+
		'              \"id\": \"668130018\"'+
		'            },'+
		'            \"message\": \"Your band of choice is as unsurprising as mine!\",'+
		'            \"can_remove\": true,'+
		'            \"created_time\": \"2009-09-28T07:46:11+0000\"'+
		'          },'+
		'          {'+
		'            \"id\": \"170173942109_5380159\",'+
		'            \"from\": {'+
		'              \"name\": \"Pat Patterson\",'+
		'              \"id\": \"667905711\"'+
		'            },'+
		'            \"message\": \"Well, it was a hard choice between The Jam, New Order and Pop Will Eat Itself...\",'+
		'            \"can_remove\": true,'+
		'            \"created_time\": \"2009-09-28T15:40:04+0000\"'+
		'          }'+
		'        ],'+
		'        \"paging\": {'+
		'          \"next\": \"https://graph.facebook.com/170173942109/comments?method=GET&metadata=true&format=json&callback=___GraphExplorerAsyncCallback___&access_token=AAA&limit=25&offset=25&__after_id=170173942109_5394082\"'+
		'        }'+
		'      }'+
		'    },'+
		'    {'+
		'      \"id\": \"66163977109\",'+
		'      \"from\": {'+
		'        \"name\": \"Pat Patterson\",'+
		'        \"id\": \"667905711\"'+
		'      },'+
		'      \"subject\": \"25 Things\",'+
		'      \"message\": \"<div><p>Rules:<br />Once you&#039;ve been tagged, you are supposed to write a note with 25 random things, facts, habits, or goals about you. At the end, choose 25 people to be tagged. You have to tag the person who tagged you. If I tagged you, it&#039;s because I want to know more about you.<br /><br />(To do this, go to “notes” under tabs on your profile page, paste these instructions in the body of the note, type your 25 random things, tag 25 people (in the right hand corner of the app) then click publish.)<br /><br />Oh, and I&#039;ll not be in the slightest bit offended if you ignore this completely.<br /><br />1. I love to travel, but not too much. Texas right now, then New York next month and Germany in May. Dopplr (travel website) tells me I flew nearly 100,000 miles last year!<br /><br />2. I&#039;ll eat just about anything; I don&#039;t really like mushrooms, but I don&#039;t bother picking them out of stuff any more. I love to &#039;go native&#039; with food - if other people are eating something, I figure it&#039;s unlikely to kill me...<br /><br />3. I love single malt scotch (hey - nobody said these have to be secrets!), especially from Islay. #1? Lagavulin.<br /><br />4. My favorite non-alcoholic drink is Tea. If I had to pick a favorite variety I&#039;d go for Taylor&#039;s Yorkshire Tea, but I usually drink Chai away from home.<br /><br />5. I&#039;m not really Pat. My legal name is Andrew Patterson. There were four Andrews in my class at school, so we all got nicknames. Mine was Pat, short for Patterson. The others were Fingers, Rico and Chads. <br /><br />6. My original university application (UCCA, for those of you who were in the UK education system at the time) was for medicine. That didn&#039;t work out - medicine&#039;s gain was computing&#039;s loss. Or something. <br /><br />7. I have Scottish ancestry (from my parents on back) - I got married in a kilt and occasionally wear it for special occasions.<br /><br />8. I have been both a mentee (once) and a mentor (twice) in Sun&#039;s SEED mentoring program. My mentor was Radia Perlman, &#039;Mother of the Internet&#039;. I&#039;m hoping my mentees become similarly distinguished. This stuff skips a generation, of course...<br /><br />9. My guilty pleasure is Cadbury&#039;s Dairy Milk Chocolate. My mother-in-law brings kilograms of CDM when she visits from the UK and it has a special drawer in our fridge. There&#039;s nothing like a couple of squares straight from the fridge with a nice cup of tea :-)<br /><br />10. I&#039;m incredibly lazy and ripped the last 5 things off my &#039;5 things&#039; blog post from a couple of years ago. But I&#039;m pretty pedantic, too, so I had to update the mentoring one.<br /><br />11. If you know me, you&#039;ll know that I&#039;m devoted to my wife, Karen, and our two boys, Tom and Alex. But not everyone knows that there&#039;s a fourth love of my life... My 1996 Porsche 911 Carrera 4 Cabriolet. Wunderbar!<br /><br />12. Karen and I met when she was at college and I was at university, but we were both working at the local McDonalds. She was my boss for the weekend, and I asked her out for a date on the Sunday afternoon. Some would argue that she&#039;s been the boss ever since...<br /><br />13. Another job at university - I spent two summers working as an operating department orderly. Oh, the stories I could tell...<br /><br />14. I used to commute by train into London. 40 minutes each way gave me lots of reading time - amongst other weighty tomes, I got through James Joyce&#039;s Ulysses and Chaucer&#039;s Canterbury Tales - in the original Middle English (that one&#039;s for you, Britta!)<br /><br />15. I can&#039;t sing, but I love Karaoke.<br /><br />16. Jeans and a t-shirt (preferably printed) - the perfect outfit for any occasion!<br /><br />17. I sometimes secretly catastrophize... what if it does all go horribly wrong!?!?!?<br /><br />18. Some favorite films - Bill &amp; Ted, The Blues Brothers, Fight Club, Back to the Future<br /><br />19. Currently reading: &quot;Small is the New Big&quot; by Seth Godin<br /><br />20. My younger brother and I once spent a very happy afternoon sitting on the flat roof between our house and our neighbor&#039;s, eating biscuits (like cookies, but nicer), drinking lemonade... and throwing bamboo canes, like javelins, through our neighbor&#039;s polythene greenhouse. Dad was somewhat annoyed by this episode. We were somewhat surprised, since he never did really like that neighbor...<br /><br />21. I&#039;m really not ambitious. I try to do my job well, and take opportunities as they come.<br /><br />22. I love living in California... The climate, the tech economy (ok - not so much right now), the ocean, the redwoods, Yosemite, San Francisco...<br /><br />23. I was a regular at Fatboy Slim&#039;s London residency - Big Beat Boutique at The End, in New Oxford Street. &quot;Right about now, the funk soul brother...&quot;<br /><br />24. I tested ENTP on Myers-Briggs. Apparently this means I wave my hands around in front of a whiteboard full of cryptic diagrams and never finish anything.</p></div>\",'+
		'      \"icon\": \"https://s-static.ak.facebook.com/rsrc.php/v1/yY/r/1gBp2bDGEuh.gif\",'+
		'      \"created_time\": \"2009-02-11T06:00:37+0000\",'+
		'      \"updated_time\": \"2009-02-15T16:01:10+0000\",'+
		'      \"comments\": {'+
		'        \"data\": ['+
		'          {'+
		'            \"id\": \"66163977109_756391\",'+
		'            \"from\": {'+
		'              \"name\": \"Susan McLucas\",'+
		'              \"id\": \"1172752471\"'+
		'            },'+
		'            \"message\": \"I like #12 hee hee\",'+
		'            \"can_remove\": true,'+
		'            \"created_time\": \"2009-02-11T06:05:57+0000\"'+
		'          },'+
		'          {'+
		'            \"id\": \"66163977109_756441\",'+
		'            \"from\": {'+
		'              \"name\": \"Britta Jafek Glade\",'+
		'              \"id\": \"632434153\"'+
		'            },'+
		'            \"message\": \"Back to the Future--classic! We had a Back to the Future marathon back in Dec with the girls. Kurt explained he used to look like Marty (he currently has a hairline like your\'s, Pat--not that there\'s anything *wrong* with that!). They loved it, and we had fun remembering the cool movie from high school (really, only the first was very good....they kinda went downhill from there).\",'+
		'            \"can_remove\": true,'+
		'            \"created_time\": \"2009-02-11T06:12:58+0000\"'+
		'          }'+
		'        ],'+
		'        \"paging\": {'+
		'          \"next\": \"https://graph.facebook.com/66163977109/comments?method=GET&metadata=true&format=json&callback=___GraphExplorerAsyncCallback___&access_token=AAA&limit=25&offset=25&__after_id=66163977109_807646\"'+
		'        }'+
		'      }'+
		'    }'+
		'  ],'+
		'  \"paging\": {'+
		'    \"previous\": \"https://graph.facebook.com/me/notes?format=json&limit=25&since=1254115331&__previous=1\",'+
		'    \"next\": \"https://graph.facebook.com/me/notes?format=json&limit=25&until=1234713669\"'+
		'  }'+
		'}';
		FacebookNotes r = parse(json);
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);

		FacebookUtil.testmode = true;
		FacebookUtil.teststubresponse = json;
		r = new FacebookNotes('TEST', 'TEST');
		System.assert(r != null);
		System.assert(r.data != null);
		System.assert(r.paging != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		FacebookNotes objRoot = new FacebookNotes(System.JSON.createParser(json));
		System.assert(objRoot != null);
		System.assert(objRoot.data == null);
		System.assert(objRoot.paging == null);
	}
}