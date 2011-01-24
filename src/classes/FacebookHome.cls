/*
 *  handle facebook home request which come in the json format of:
{"data": [
      {
         "id": "1111111111",
         "from": {
            "name": "Testing Data",
            "id": "1111111111"
         },
         "to": {
            "data": [
               {
                  "name": "Testing Data",
                  "id": "1111111111"
               }
            ]
         },
         "message": "http://www.youtube.com/watch?v=dAaBYQzN7Lw&feature=fvst",
         "picture": "http://external.ak.fbcdn.net/safe_image.php?d=c560caa00179e3eb1d88a9644fd8520b&w=130&h=130&url=http%3A%2F%2Fi.ytimg.com%2Fvi%2FdAaBYQzN7Lw%2F0.jpg",
         "link": "http://www.youtube.com/watch?v=dAaBYQzN7Lw&feature=fvst",
         "source": "http://www.youtube.com/v/dAaBYQzN7Lw&autoplay=1",
         "name": "Santana Soul Sacrifice Woodstock 1969",
         "caption": "www.youtube.com",
         "description": "BEST DRUM SOLO EVER!!!!!  The Woodstock Music and Art Fair was a historic event held at Max Yasgur's 600 acre (2.4 km\u00b2; 240 ha) dairy farm in the rural town of Bethel, New York from August 15 to August 18, 1969. Bethel (Sullivan County) is 43 miles (69 km) southwest of the town of Woodstock, New Yor...",
         "icon": "http://static.ak.fbcdn.net/rsrc.php/z9XZ8/hash/976ulj6z.gif",
         "actions": [
            {
               "name": "Comment",
               "link": "http://www.facebook.com/1111111111/posts/1111111111"
            },
            {
               "name": "Like",
               "link": "http://www.facebook.com/1111111111/posts/1111111111"
            }
         ],
         "privacy": {
            "description": "Everyone",
            "value": "EVERYONE"
         },
         "type": "video",
         "created_time": "2010-08-16T21:48:57+0000",
         "updated_time": "2010-08-16T21:49:12+0000",
         "likes": 1,
         "comments": {
            "data": [
               {
                  "id": "1111111111",
                  "from": {
                     "name": "Testing Data",
                     "id": "1111111111"
                  },
                  "message": "Testing Data",
                  "created_time": "2010-08-16T21:49:07+0000"
               },
               {
                  "id": "1111111111",
                  "from": {
                     "name": "Testing Data",
                     "id": "1111111111"
                  },
                  "message": "Testing Data",
                  "created_time": "1111111111"
               }
            ],
            "count": 2
         }
      }],
	   "paging": {
	      "previous": "https://graph.facebook.com/11111111111/home?access_token=1111111111%7C2.cpgDS4674m7uPHfRDq_tww__.3600.1111111111111%7CmMqJmYodDNDp52Hv14Y7HrIyYyM.&limit=25&since=2010-08-16T21%3A48%3A57%2B0000",
	      "next": "https://graph.facebook.com/11111111111/home?access_token=1111111111%7C2.cpgDS4674m7uPHfRDq_tww__.3600.111111111111111%7CmMqJmYodDNDp52Hv14Y7HrIyYyM.&limit=25&until=2010-08-13T13%3A46%3A07%2B0000"
	   }
	}

 * August 2010 
 */


public class FacebookHome extends FacebookObject{
	/*
	JSONObject data = new JSONObject();
	public List<FacebookPost> allHome = new List<FacebookPost>();
	
	
	// Constructor
	public FacebookHome(String clientid, String username, String teststub) {
		this.clientid = clientid;
		this.getFacebookHome(clientid, username,teststub, null);
	}
	
	
	// Gets the Home Feed, if last parameter (pageUrl) is passed it will force that url to be used on the API call.
	public void getFacebookHome(String clientid, String username, String teststub, String pageUrl) {
		if(teststub != null)
			super.setTestStubResponse(teststub);
		
		super.isAuthenticated(clientid);
		if(pageUrl == null){
			data = super.doAPICall(username+'/home');
		}else {
			data = super.doAPICall('',pageUrl);
		}
		JSONObject.value p = data.getValue('data');
		
		if(p != null){
			JSONObject.value[] vals = p.values; 
		
			for(Integer i = 0; i < vals.size(); i++)
			{
				allHome.add(new FacebookPost(vals[i].obj));
			}
			if(this.hasPaging(this.data)){
				this.nextPage = this.data.getValue('paging').obj.getValue('next').str.replace('\\','');
				this.prevPage = this.data.getValue('paging').obj.getValue('previous').str.replace('\\','');
			}
		}
	}
	
	public void getNextPage(){
		if(this.nextPage != null)
			this.getFacebookHome(this.clientid, null, null,this.nextPage);
	}
	
	public void getPreviousPage(){
		if(this.prevPage != null)
			this.getFacebookHome(this.clientid, null, null,this.prevPage);
	}

	public static testmethod void test_Home()
	{
		String stub = '{"data": [{ "id": "1111111111", "from": { "name": "Testing Data","id": "1111111111"},"to": { "data": [{"name": "Testing Data","id": "1111111111"} ]},"message": "http://www.youtube.com/watch?v=dAaBYQzN7Lw&feature=fvst","picture": "http://external.ak.fbcdn.net/safe_image.php?d=c560caa00179e3eb1d88a9644fd8520b&w=130&h=130&url=http%3A%2F%2Fi.ytimg.com%2Fvi%2FdAaBYQzN7Lw%2F0.jpg","link": "http://www.youtube.com/watch?v=dAaBYQzN7Lw&feature=fvst","source": "http://www.youtube.com/v/dAaBYQzN7Lw&autoplay=1","name": "Santana Soul Sacrifice Woodstock 1969","caption": "www.youtube.com","description": "BEST DRUM SOLO EVER!!!!!The Woodstock Music and Art Fair was a historic event held at Max Yasgur\'s 600 acre (2.4 km\\u00b2; 240 ha) dairy farm in the rural town of Bethel, New York from August 15 to August 18, 1969. Bethel (Sullivan County) is 43 miles (69 km) southwest of the town of Woodstock, New Yor...","icon": "http://static.ak.fbcdn.net/rsrc.php/z9XZ8/hash/976ulj6z.gif","actions": [ {"name": "Comment","link": "http://www.facebook.com/1111111111/posts/1111111111" }, {"name": "Like","link": "http://www.facebook.com/1111111111/posts/1111111111" }],"privacy": { "description": "Everyone", "value": "EVERYONE"},"type": "video","created_time": "2010-08-16T21:48:57+0000","updated_time": "2010-08-16T21:49:12+0000","likes": 1,"comments": { "data": [{"id": "1111111111","from": {"name": "Testing Data","id": "1111111111"},"message": "Testing Data","created_time": "2010-08-16T21:49:07+0000"},{"id": "1111111111","from": {"name": "Testing Data","id": "1111111111"},"message": "Testing Data","created_time": "1111111111"} ], "count": 2}}], "paging": {"previous": "https://graph.facebook.com/11111111111/home?access_token=1111111111%7C2.cpgDS4674m7uPHfRDq_tww__.3600.1111111111111%7CmMqJmYodDNDp52Hv14Y7HrIyYyM.&limit=25&since=2010-08-16T21%3A48%3A57%2B0000","next": "https://graph.facebook.com/11111111111/home?access_token=1111111111%7C2.cpgDS4674m7uPHfRDq_tww__.3600.111111111111111%7CmMqJmYodDNDp52Hv14Y7HrIyYyM.&limit=25&until=2010-08-13T13%3A46%3A07%2B0000" } }';
		
		FacebookHome fbl = new FacebookHome('136520473033312', '1307240381', stub);
		
		System.assertEquals(fbl.allHome.size(), 1);
		System.assertEquals(fbl.allHome[0].id, '1111111111');
		System.assertEquals(fbl.allHome[0].fromUser.id, '1111111111');
		System.assertEquals(fbl.allHome[0].fromUser.name, 'Testing Data');
		System.assertEquals(fbl.allHome[0].message, 'http://www.youtube.com/watch?v=dAaBYQzN7Lw&feature=fvst');
		System.assertEquals(fbl.allHome[0].name, 'Santana Soul Sacrifice Woodstock 1969');
		System.assertEquals(fbl.allHome[0].actions[0].name, 'Comment');
		System.assertEquals(fbl.allHome[0].actions[0].link, 'http://www.facebook.com/1111111111/posts/1111111111');
		System.assertEquals(fbl.allHome[0].likes , 1);
		System.assertEquals(fbl.alLHome[0].comments[0].id, '1111111111');
		System.assertEquals(fbl.alLHome[0].comments[0].message, 'Testing Data');
		System.assertEquals(fbl.alLHome[0].comments[0].fromUser.name, 'Testing Data');
	}*/
}