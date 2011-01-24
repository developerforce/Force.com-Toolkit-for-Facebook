/*
 *  handle facebook feed request which come in the json format of a POST
 * August 2010 
 */
public class FacebookFeed extends FacebookObject{
	/*
	JSONObject data = new JSONObject();
	public List<FacebookPost> allFeed = new List<FacebookPost>();
	
	// Constructor
	public FacebookFeed(String clientid, String username, String teststub) {
		this.clientid = clientid;
		this.getFacebookFeed(clientid, username,teststub, null);
	}
	
	
	// Gets the Home Feed, if last parameter (pageUrl) is passed it will force that url to be used on the API call.
	public void getFacebookFeed(String clientid, String username, String teststub, String pageUrl) {
		
		if(teststub != null)
			super.setTestStubResponse(teststub);
		
		super.isAuthenticated(clientid);
		if(pageUrl == null){
			data = super.doAPICall(username+'/feed');
		}else {
			data = super.doAPICall('',pageUrl);
		}
		JSONObject.value p = data.getValue('data');
		
		if(p != null){
			JSONObject.value[] vals = p.values; 
		
			for(Integer i = 0; i < vals.size(); i++)
			{
				allFeed.add(new FacebookPost(vals[i].obj));
			}
			if(this.hasPaging(this.data)){
				this.nextPage = this.data.getValue('paging').obj.getValue('next').str.replace('\\','');
				this.prevPage = this.data.getValue('paging').obj.getValue('previous').str.replace('\\','');
			}
		}
	}
	
	public void getNextPage(){
		if(this.nextPage != null)
			this.getFacebookFeed(this.clientid, null, null,this.nextPage);
	}
	
	public void getPreviousPage(){
		if(this.prevPage != null)
			this.getFacebookFeed(this.clientid, null, null,this.prevPage);
	}

	public static testmethod void test_Feed()
	{
		String stub = '{"data": [{"id": "8888888888_1424828228879","from": {"name": "testTwo","id": "8888888888"},"to": {"data": [{"name": "testTwo","id": "8888888888"}]},"picture": "http://vthumb.ak.fbcdn.net/vthumb-ak-sf2p/v33374/30/97/1180498208/t1180498208_1507829733949_1471.jpg","link": "http://www.facebook.com/video/video.php?v=1507829733949","source": "http://video.ak.fbcdn.net/cfs-ak-ash2/33207/555/1507829733949_64271.mp4","name": "Actitud celeste! [HQ]","icon": "http://static.ak.fbcdn.net/rsrc.php/z75M0/hash/6z01mawk.gif","type": "video","created_time": "2010-08-17T21:03:32+0000","updated_time": "2010-08-17T21:03:32+0000"},{"id": "2222222222","from": {"name": "TestUser","id": "5555555555"},"to": {"data": [{"name": "testTwo","id": "8888888888"}]},"message": "Testing for toolkit","actions": [{"name": "Comment","link": "http://www.facebook.com/8888888888/posts/1234567890"},{"name": "Like","link": "http://www.facebook.com/8888888888/posts/1234567890"}],"type": "status","created_time": "2010-08-17T13:09:38+0000","updated_time": "2010-08-18T13:49:07+0000","comments": {"data": [{"id": "2222222222_544028","from": {"name": "testTwo","id": "8888888888"},"message": "123","created_time": "2010-08-18T13:49:04+0000"},{"id": "2222222222_544029","from": {"name": "testTwo","id": "8888888888"},"message": "123","created_time": "2010-08-18T13:49:07+0000"}],"count": 14}}],"paging": {"previous": "https://graph.facebook.com/8888888888/feed?access_token=2227470867%7C2.BEI_D98P1P_djN_9eUkwEw__.3600.1282143600-8888888888%7CHfK-1j2j9mrzTc19uMjWV-ffGKA.&limit=25&since=2010-08-18T13%3A14%3A16%2B0000","next": "https://graph.facebook.com/8888888888/feed?access_token=2227470867%7C2.BEI_D98P1P_djN_9eUkwEw__.3600.1282143600-8888888888%7CHfK-1j2j9mrzTc19uMjWV-ffGKA.&limit=25&until=2009-04-28T16%3A43%3A47%2B0000"}}';

		FacebookFeed fbl = new FacebookFeed('136520473033312', '1307240381', stub);
		System.assertEquals(fbl.allFeed.size(), 2);
		System.assertEquals(fbl.allFeed[1].id, '2222222222');
		System.assertEquals(fbl.allFeed[1].fromUser.id, '5555555555');
		System.assertEquals(fbl.allFeed[1].fromUser.name, 'TestUser');
		System.assertEquals(fbl.allFeed[1].message, 'Testing for toolkit');
		//System.assertEquals(fbl.allFeed[1].name, null); If called will return an null pointer error
		System.assertEquals(fbl.allFeed[1].actions[0].name, 'Comment');
		System.assertEquals(fbl.allFeed[1].actions[0].link, 'http://www.facebook.com/8888888888/posts/1234567890');
		//System.assertEquals(fbl.allFeed[1].likes , null); If called will return an null pointer error
		System.assertEquals(fbl.allFeed[1].comments[0].id, '2222222222_544028');
		System.assertEquals(fbl.allFeed[1].comments[0].message, '123');
		System.assertEquals(fbl.allFeed[1].comments[0].fromUser.name, 'testTwo');
		System.assertEquals(fbl.allFeed[1].comments[0].created_time, '2010-08-18T13:49:04+0000');
	}*/
}