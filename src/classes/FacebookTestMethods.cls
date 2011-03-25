public class FacebookTestMethods {

	public static testmethod void TestGetUserData(){
		FacebookUser a = new FacebookUser('me');
		
		Test.startTest();
		a.setTestStubResponse('{"id": "testing","name": "testing","first_name": "testing","last_name": "testing","link": "testing","birthday": "testing","hometown": {"id": 12312312312313,"name": "testing"},"location": {"id": 12312312312313,"name": "testing"},"bio": "testing","quotes": "testing","work": [{"employer": {"id": 12312312312313,"name": "Test"},"position": {"id": 12312312312313,"name": "testing"},"start_date": "testing","end_date": "testing"}],"education": [{"school": {"id": 12312312312313,"name": "testing"}},{"school": {"id": 12312312312313,"name": "testing"},"concentration": [{"id": 12312312312313,"name": "testing"},{"id": 12312312312313,"name": "testing"}]}],"gender": "testing","interested_in": ["testing","testing"],"meeting_for": ["testing","testing","testing","testing"],"relationship_status": "testing","religion": "testing","political": "testing","website": "testing","timezone": 0,"locale": "testing","updated_time": "testing"}');
		a.getData();
		Test.stopTest();
		
		System.assertEquals(a.name,'testing','Incorrect value retrieved from test stub data.');
		System.assertEquals(a.link,'testing','Incorrect value retrieved from test stub data.');
		System.assertEquals(a.gender,'testing','Incorrect value retrieved from test stub data.');
		System.assertEquals(a.meeting_for.size(),4,'Incorrect Size of list');
	}
		
		
	public static testmethod void TestFriends(){
		FacebookUser a = new FacebookUser('me');
		
		Test.startTest();		
		a.setTestStubResponse('{"data": [{"name": "Friend One","id": "123123123"},{"name": "Friend Two","id": "123123123"},]}');
		a.getFriendData();
		Test.stopTest();
		
		System.assertEquals(a.friends.size(),2,'Incorrect size of list.');
		System.assertEquals(a.friends[0].name,'Friend One','Incorrect value retrieved from test stub data.');
		System.assertEquals(a.friends[0].id,'123123123','Incorrect value retrieved from test stub data.');
	}
	
	public static testmethod void TestEvents(){
		FacebookUser a = new FacebookUser('me');
		
		Test.startTest();	
		a.setTestStubResponse('{"data": [{"name": "19/8 - 22:00hs Cacau Pires & Banda - m\\u00fasica del brasil","venue": {"street": "26 de marzo 3353 esq pereira de la luz"},"start_time": "2010-08-20T04:00:00+0000","end_time": "2010-08-20T13:00:00+0000","location": "El Pico resto-pub","id": "142450459121815","rsvp_status": "attending"},{"name": "Feria Er\\u00f2tica en Cafe Babel","start_time": "2010-08-19T02:00:00+0000","end_time": "2010-08-19T02:30:00+0000","location": "26 de marzo 3500 ","id": "106513419405969","rsvp_status": "attending"}],"paging": {"previous": "https://graph.facebook.com/1477976591/events?access_token=2227470867%7C2.MIYfIFdSfxRbAzMPRjx51A__.3600.1284066000-1477976591%7CMqrgJfLOVLzCkGwj3KM14FvpaHc&limit=25&since=2010-08-20T04%3A00%3A00%2B0000","next": "https://graph.facebook.com/1477976591/events?access_token=2227470867%7C2.MIYfIFdSfxRbAzMPRjx51A__.3600.1284066000-1477976591%7CMqrgJfLOVLzCkGwj3KM14FvpaHc&limit=25&until=2010-08-19T01%3A59%3A59%2B0000"}}');
		a.getEventData();
		Test.stopTest();
		
	}
	
	public static testmethod void TestPhoto(){
		FacebookUser a = new FacebookUser('me');
		
		Test.startTest();
		a.setTestStubResponse('{"data": [{"id": "1423785282806","from": {"name": "Testuser Chesterfrenchfans","id": "1477976591"},"tags": {"data": [{"id": "1477976591","name": "Testuser Chesterfrenchfans","x": 37.4074,"y": 36.4902,"created_time": "2010-08-16T21:33:53+0000"}]},"name": "testing","picture": "http://photos-c.ak.fbcdn.net/hphotos-ak-snc4/hs396.snc4/45931_1423785282806_1477976591_31103903_4271049_s.jpg","source": "http://sphotos.ak.fbcdn.net/hphotos-ak-snc4/hs396.snc4/45931_1423785282806_1477976591_31103903_4271049_n.jpg","height": 359,"width": 540,"link": "http://www.facebook.com/photo.php?pid=31103903&id=1477976591","icon": "http://static.ak.fbcdn.net/rsrc.php/z2E5Y/hash/8as8iqdm.gif","created_time": "2010-08-16T21:29:07+0000","updated_time": "2010-08-18T13:13:33+0000","comments": {"data": [{"id": "1423785282806_724253","from": {"name": "Testuser Chesterfrenchfans","id": "1477976591"},"message": "testing","created_time": "2010-08-18T20:54:21+0000"},{"id": "1423785282806_724274","from": {"name": "Testuser Chesterfrenchfans","id": "1477976591"},"message": "sdfsfs","created_time": "2010-08-18T21:15:33+0000"}],"paging": {"previous": "https://graph.facebook.com/1423785282806/comments?access_token=2227470867%7C2.MIYfIFdSfxRbAzMPRjx51A__.3600.1284066000-1477976591%7CMqrgJfLOVLzCkGwj3KM14FvpaHc&limit=25&since=2010-08-18T21%3A15%3A33%2B0000","next": "https://graph.facebook.com/1423785282806/comments?access_token=2227470867%7C2.MIYfIFdSfxRbAzMPRjx51A__.3600.1284066000-1477976591%7CMqrgJfLOVLzCkGwj3KM14FvpaHc&limit=25&until=2010-08-18T20%3A54%3A20%2B0000"}}}],"paging": {"previous": "https://graph.facebook.com/1477976591/photos?access_token=2227470867%7C2.MIYfIFdSfxRbAzMPRjx51A__.3600.1284066000-1477976591%7CMqrgJfLOVLzCkGwj3KM14FvpaHc&limit=25&since=2010-08-16T21%3A29%3A07%2B0000","next": "https://graph.facebook.com/1477976591/photos?access_token=2227470867%7C2.MIYfIFdSfxRbAzMPRjx51A__.3600.1284066000-1477976591%7CMqrgJfLOVLzCkGwj3KM14FvpaHc&limit=25&until=2010-08-16T21%3A29%3A06%2B0000"}}');
		a.getPhotoData();
		Test.stopTest();
	}
	
	public static testmethod void TestLink(){
		FacebookUser a = new FacebookUser('me');
		
		Test.startTest();
		a.setTestStubResponse('{"data": [{"id": "testing","from": {"name": "testing","id": "123123123"},"to": {"data": [{"name": "testing","id": "123123123"}]},"message": "testing","actions": [{"name": "testing","link": "testing"},{"name": "testing","link": "testing"}],"type": "testing","created_time": "testing","updated_time": "testing","comments": {"data": [{"id": "testing","from": {"name": "testing","id": "123123123"},"message": "testing","created_time": "testing"},{"id": "testing","from": {"name": "testing","id": "123123123"},"message": "testing","created_time": "testing"}],"count": 14}}],"paging": {"previous": "testing","next": "testing"}}');
		a.getLinkData();
		Test.stopTest();
		
		System.assertEquals(a.links.size(),1,'Incorrect size of list.');
		System.assertEquals(a.links[0].id,'testing','Incorrect value retrieved from test stub data.');
		System.assertEquals(a.links[0].fromName,'testing','Incorrect value retrieved from test stub data.');
		System.assertEquals(a.links[0].getHasComments(),true,'Incorrect value returned.');
	}

	public static testmethod void TestAlbums(){
		FacebookUser a = new FacebookUser('me');
		
		Test.startTest();
		a.setTestStubResponse('{"data": [{"id": "123123123123123","from": {"name": "testing","id": "123123123123123"},"name": "testing","description": "testing","location": "testing","link": "testing","privacy": "testing","count": 1,"created_time": "testing","updated_time": "testing","comments": {"data": [{"id": "123123123123123","from": {"name": "Testuser Chesterfrenchfans","id": "123123123123123"},"message": "testing","created_time": "testing"}],"paging": {"previous": "testing","next": "testing"}}},{"id": "123123123123123","from": {"name": "testing","id": "123123123123123"},"name": "testing","link": "testing","privacy": "testing","count": 2,"created_time": "testing","updated_time": "testing"}],"paging": {"previous": "testing","next": "testing"}}');
		a.getAlbumData();
		Test.stopTest();
		
		System.assertEquals(a.albums.size(),2,'Incorrect size of list.');
		System.assertEquals(a.albums[0].id,'123123123123123','Incorrect value retrieved from test stub data.');
		System.assertEquals(a.albums[0].fromName,'testing','Incorrect value retrieved from test stub data.');
		System.assertEquals(a.albums[0].getHasComments(),true,'Incorrect value returned.');	
	}

	public static testmethod void TestPost(){
		FacebookUser a = new FacebookUser('me');
		
		Test.startTest();
		a.setTestStubResponse('{"data": [{"id": "testing","from": {"name": "testing","id": "123123123"},"to": {"data": [{"name": "testing","id": "123123123"}]},"message": "testing","actions": [{"name": "testing","link": "testing"},{"name": "testing","link": "testing"}],"type": "testing","created_time": "testing","updated_time": "testing","comments": {"data": [{"id": "testing","from": {"name": "testing","id": "123123123"},"message": "testing","created_time": "testing"},{"id": "testing","from": {"name": "testing","id": "123123123"},"message": "testing","created_time": "testing"}],"count": 14}}],"paging": {"previous": "testing","next": "testing"}}');
		a.getTaggedData();
		a.getHomeData();
		a.getFeedData();
		a.getPostData();
		Test.stopTest();
		
		System.assertEquals(a.posts.size(),1,'Incorrect size of list.');
		System.assertEquals(a.posts[0].id,'testing','Incorrect value retrieved from test stub data.');
		System.assertEquals(a.posts[0].fromName,'testing','Incorrect value retrieved from test stub data.');
		System.assertEquals(a.posts[0].to.size(),1,'Incorrect size of list.');
		System.assertEquals(a.posts[0].getHasComments(),true,'Incorrect value returned.');
		System.assertEquals(a.posts[0].getHasTo(),true,'Incorrect value returned.');
	}
	
	
	
	public static testmethod void TestGroup(){
		FacebookUser a = new FacebookUser('me');
		
		Test.startTest();
		a.setTestStubResponse('{"data": [{"name": "FACEBOOK DEVELOPERS","id": "162880340461","venue":{"street":"testing"}},{"name": "Facebook Application Developers ","id": "17866072744"},{"name": "Facebook Developers","id": "2205007948"}]}');
		a.getGroupData();
		Test.stopTest();
	}


	public static testmethod void TestPage(){
		FacebookUser a = new FacebookUser('me');
		
		Test.startTest();
		a.setTestStubResponse('{"data": [{"name": "Testing","category": "Interest","id": "123123123123","created_time": "testdate"},{"name": "Testing","category": "Interest","id": "123123123123","created_time": "testdate"}]}');
		a.getMusicData();
		a.getLikeData();
		a.getMovieData();
		a.getTelevisionData();
		a.getBookData();
		a.getActivityData();
		a.getInterestData();
		a.getVideoData();
		a.getNoteData();
		Test.stopTest();
		
		System.assertEquals(a.interests.size(),2,'Incorrect size of list.');
		System.assertEquals(a.interests[0].name,'Testing','Incorrect value retrieved from test stub data.');
		System.assertEquals(a.interests[0].category,'Interest','Incorrect value retrieved from test stub data.');
	}
	
	public static testmethod void TestProfileImage() {
		FacebookStandardController fsc = new FacebookStandardController();
		fsc.fbID = '717838202';
		fsc.clientID = '136520473033312'; 
		String url = fsc.getProfileImageUrl();
		
		System.assert(url.startsWith('http'));
		
	}
	public static testmethod void TestSocialController() {
		FacebookSocialController fsc = new FacebookSocialController();
		fsc.getSiteUrl();
    	fsc.getActivityURL();
   		fsc.getRecommendationsURL();
	}
	
	public static testmethod void TestFacebookUserController() {
		FacebookTestUserController fsc = new FacebookTestUserController();
		FacebookUser a = new FacebookUser('717838202');
		fsc.uid = '717838202';
		
		a.setTestStubResponse('{"data": [{"name": "Testing","category": "Interest","id": "123123123123","created_time": "testdate"},{"name": "Testing","category": "Interest","id": "123123123123","created_time": "testdate"}]}');
		
		fsc.user = a;
		fsc.getActivitiesData();
		fsc.getAlbumsData();
		fsc.getBooksData();
		fsc.getEventsData();
		fsc.getFeedData();
		fsc.getFriendsData();
		fsc.getGroupsData();
		fsc.getHomeData();
		fsc.getInterestsData();
		fsc.getLikesData();
		fsc.getLinksData();
		fsc.getMoviesData();
		fsc.getMusicData();
		fsc.getNotesData();
		fsc.getPhotoData();
		fsc.getPostsData();
		fsc.getStatusesData();
		fsc.getTaggedData();
		fsc.getTelevisionData();
		fsc.getUserData();
		
	}

	public static testmethod void TestStatus(){
		FacebookUser a = new FacebookUser('me');
		
		Test.startTest();
		a.setTestStubResponse('{"data": [{"id": "149001695134192","from": {"name": "Testuser Chesterfrenchfans","id": "1477976591"},"message": "hello","updated_time": "2010-09-09T16:38:59+0000","comments": {"data": [{"id": "149001695134192_1369764","from": {"name": "Testuser Chesterfrenchfans","id": "1477976591"},"message": "bye","created_time": "2010-09-09T16:39:06+0000"}],"paging": {"previous": "asd","next": "asd"}}},{"id": "57807484252","from": {"name": "Testuser Chesterfrenchfans","id": "1477976591"},"message": "asd","updated_time": "2009-03-16T15:27:17+0000"}],"paging": {"previous": "asd","next": "asd"}}');
		a.getStatusData();
		Test.stopTest();
	}
	
  /**
   * Test methods for publishing
   * Jeff Douglas (jeff@appirio.com)
   */	
	public static testmethod void TestPublish() {
	 
    FacebookPublish fp = new FacebookPublish('me');	
	 
		Map<String,String> params = new Map<String,String>();
		params.put('test','test');
		
		Test.startTest();
		fp.testmode = true;
		
		fp.postToWall(params);
		System.assertEquals(fp.teststubresponse,'Status=OK, StatusCode=200');
		
		fp.postEvent(params);
		System.assertEquals(fp.teststubresponse,'Status=OK, StatusCode=200');
		
    fp.postCheckin(params);
    System.assertEquals(fp.teststubresponse,'Status=OK, StatusCode=200');
    
    fp.postLink(params);
    System.assertEquals(fp.teststubresponse,'Status=OK, StatusCode=200');
    
    fp.postNote(params);
    System.assertEquals(fp.teststubresponse,'Status=OK, StatusCode=200');
    
    fp.postLike('someid');
    System.assertEquals(fp.teststubresponse,'Status=OK, StatusCode=200');
    
    fp.postComment('someid', params);
    System.assertEquals(fp.teststubresponse,'Status=OK, StatusCode=200');
		
		Test.stopTest();
		
	}	
	
}