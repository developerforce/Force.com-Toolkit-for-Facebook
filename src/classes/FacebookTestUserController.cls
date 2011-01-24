/**
 * This is the Controller for the test page. 
 * @author Quinton Wall - qwall@salesforce.com
 * @author Gastón Esmela - gesmela@salesforce.com
 */

public with sharing class FacebookTestUserController {
	public string uid {get;set;}
	public string action {get;set;}
	
	public FacebookUser user {get;set;}
	
	public void getUserData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getData();
		
		this.action = 'getData';
	}
	
	public void getFriendsData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		
		Map<String,String> params = new Map<string,string>();
		params.put('fields','id,name,hometown,gender,link');
		
		user.getFriendData(params);
		
		this.action = 'getFriends';
	}
	
	public void getHomeData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getHomeData();
		
		this.action = 'getHome';
	}
	
	public void getPhotoData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getPhotoData();
		
		this.action = 'getPhotos';
	}
	
	public void getAlbumsData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getAlbumData();
		
		this.action = 'getAlbums';
	}
	
	public void getFeedData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getFeedData();
		
		this.action = 'getFeed';
	}
	
	public void getPostsData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getPostData();
		
		this.action = 'getPosts';
	}
	
	public void getTaggedData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getTaggedData();
		
		this.action = 'getTagged';
	}
	
	public void getLikesData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getLikeData();
		
		this.action = 'getLikes';
	}
	
	public void getActivitiesData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getActivityData();
		
		this.action = 'getActivities';
	}
	
	public void getMoviesData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getMovieData();
		
		this.action = 'getMovies';
	}
	
	public void getBooksData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getBookData();
		
		this.action = 'getBooks';
	}
	
	public void getInterestsData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getInterestData();
		
		this.action = 'getInterests';
	}
	
	public void getTelevisionData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getTelevisionData();
		
		this.action = 'getTelevision';
	}
	
	public void getMusicData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getMusicData();
		
		this.action = 'getMusic';
	}
	
	public void getGroupsData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getGroupData();
		
		this.action = 'getGroups';
	}
	
	public void getStatusesData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getStatusData();
		
		this.action = 'getStatuses';
	}
	
	public void getEventsData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getEventData();
		
		this.action = 'getEvents';
	}
	
	public void getNotesData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getNoteData();
		
		this.action = 'getNotes';
	}
	
	public void getLinksData(){
		
		this.user = new FacebookUser(this.uid);
		user.clientId = '136520473033312';
		user.getLinkData();
		
		this.action = 'getLinks';
	}
	
	public static testmethod void codeCoverage(){
		FacebookTestUserController a = new FacebookTestUserController();	
	}
}