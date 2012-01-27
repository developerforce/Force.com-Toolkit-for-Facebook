/**
 * This is the Controller for the test page. 
 * @author Quinton Wall - qwall@salesforce.com
 * @author Gastón Esmela - gesmela@salesforce.com
 */

public with sharing class FacebookTestUserController extends FacebookLoginController {
	transient public string uid {get;set;}
	transient public string action {get;set;}
	transient public string errorMessage {get;set;}
	
	transient public FacebookUser user {get;set;}
	transient public FacebookPhotos photos {get;set;}
	transient public FacebookAlbums albums {get;set;}
	transient public FacebookPosts posts {get;set;}
	transient public FacebookLikes likes {get;set;}
	transient public FacebookRefs refs {get;set;}
	transient public FacebookGroups groups {get;set;}
	transient public FacebookStatusMessages statuses {get;set;}
	transient public FacebookEvents events {get;set;}
	transient public FacebookNotes notes {get;set;}
	transient public FacebookLinks links {get;set;}
	transient public FacebookUsers users {get;set;}
	transient public FacebookPages pages_z {get;set;}
	transient public FacebookPlaces places {get;set;}
	transient public FacebookCheckins checkins {get;set;}
	
	public FacebookTestUserController() {
		uid = 'me';
	}

	public void getUserData(){
		try {
			user = new FacebookUser(FacebookToken.getAccessToken(), uid);
			action = 'getData';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getFriendsData(){
		try {
			Map<String,String> params = new Map<string,string>{'fields' => 'id,name,hometown,gender,link'};
			
			users = new FacebookUsers(FacebookToken.getAccessToken(), uid+'/friends', params);
			action = 'getFriends';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getHomeData(){
		try {
			// TODO - add (access_token, id, params ) constructors for FacebookPosts etc
			posts = FacebookPosts.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/home'));			
			action = 'getHome';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getPhotoData(){
		try {
			photos = FacebookPhotos.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/photos'));
			action = 'getPhotos';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getAlbumsData(){
		try {
			albums = FacebookAlbums.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/albums'));			
			action = 'getAlbums';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getFeedData(){
		try {
			posts = FacebookPosts.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/feed'));			
			action = 'getFeed';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getPostsData(){
		try {
			posts = FacebookPosts.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/posts'));		
			action = 'getPosts';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getTaggedData(){
		try {
			posts = FacebookPosts.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/tagged'));		
			action = 'getTagged';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getLikesData(){
		try {
			likes = FacebookLikes.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/likes'));
			action = 'getLikes';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getActivitiesData(){
		try {
			refs = FacebookRefs.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/activities'));
			action = 'getActivities';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getMoviesData(){
		try {
			refs = FacebookRefs.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/movies'));
			action = 'getMovies';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getBooksData(){
		try {
			refs = FacebookRefs.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/books'));
			action = 'getBooks';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getInterestsData(){
		try {
			refs = FacebookRefs.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/interests'));		
			action = 'getInterests';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getTelevisionData(){
		try {
			refs = FacebookRefs.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/television'));
			action = 'getTelevision';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getMusicData(){
		try {
			refs = FacebookRefs.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/music'));
			action = 'getMusic';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getGroupsData(){
		try {
			groups = FacebookGroups.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/groups'));
			action = 'getGroups';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getStatusesData(){
		try {
			statuses = FacebookStatusMessages.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/statuses'));
			action = 'getStatuses';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getEventsData(){
		try {
			events = FacebookEvents.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/events'));		
			action = 'getEvents';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getNotesData(){
		try {
			notes = FacebookNotes.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/notes'));		
			action = 'getNotes';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getLinksData(){
		try {
			links = FacebookLinks.parse(FacebookUtil.get(FacebookToken.getAccessToken(), uid+'/links'));
			action = 'getLinks';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void searchPosts(){
		try {
			posts = FacebookPosts.search(FacebookToken.getAccessToken(), uid);
			action = 'getPosts';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void searchUsers(){
		try {
			users = FacebookUsers.search(FacebookToken.getAccessToken(), uid);
			action = 'getUsers';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void searchPages(){
		try {
			pages_z = FacebookPages.search(FacebookToken.getAccessToken(), uid);
			action = 'getPages';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void searchEvents(){
		try {
			events = FacebookEvents.search(FacebookToken.getAccessToken(), uid);
			action = 'getEvents';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void searchGroups(){
		try {
			groups = FacebookGroups.search(FacebookToken.getAccessToken(), uid);
			action = 'getGroups';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void searchPlaces(){
		try {
			// Arbitrary center and distance for place search
			// Coordinates are for Mission Dolores Park, San Francisco
			Map<String, String> params = new Map<String, String>{ 'center' => '37.76,-122.427', 'distance' => '1000' };

			places = FacebookPlaces.search(FacebookToken.getAccessToken(), uid, params);
			action = 'getPlaces';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void searchCheckins(){
		try {
			// Checkins doesn't support search on a query
			checkins = FacebookCheckins.search(FacebookToken.getAccessToken());
			action = 'getCheckins';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public static testmethod void codeCoverage(){
		// TODO	
	}
}