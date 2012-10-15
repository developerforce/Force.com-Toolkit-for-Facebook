/**
 * This is the Controller for the test page. 
 * @author Quinton Wall - qwall@salesforce.com
 * @author Gastón Esmela - gesmela@salesforce.com
 */

public with sharing class FacebookTestUserController extends FacebookLoginController {
	// Set this to an auth provider id (e.g. '0SOD00000000012') to use an 
	// auth provider (new in Spring '12)
	private static String authProviderId = null;

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

	// You wouldn't usually need to override init(). We do here to be able
	// to change the behavior depending on whether we want to use the platform
	// auth provider. If you want to use the auth provider in your controller,
	// just don't extend FacebookLoginController
	public override PageReference init() {
		return ( authProviderId == null ) ? super.init() : null;
	}
	
    public static String getAccessToken() {
    	return ( authProviderId == null ) 
    		? FacebookToken.getAccessToken()
    		: Auth.AuthToken.getAccessToken(authProviderId, 'facebook');
    }

	public void getUserData(){
		try {
			user = new FacebookUser(getAccessToken(), uid);
			action = 'getData';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getFriendsData(){
		try {
			Map<String,String> params = new Map<string,string>{'fields' => 'id,name,hometown,gender,link'};
			
			users = new FacebookUsers(getAccessToken(), uid+'/friends', params);
			action = 'getFriends';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getHomeData(){
		try {
			// TODO - add (access_token, id, params ) constructors for FacebookPosts etc
			posts = new FacebookPosts(getAccessToken(), uid+'/home');			
			action = 'getHome';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getPhotoData(){
		try {
			photos = new FacebookPhotos(getAccessToken(), uid+'/photos');
			action = 'getPhotos';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getAlbumsData(){
		try {
			albums = new FacebookAlbums(getAccessToken(), uid+'/albums');			
			action = 'getAlbums';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getFeedData(){
		try {
			posts = new FacebookPosts(getAccessToken(), uid+'/feed');			
			action = 'getFeed';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getPostsData(){
		try {
			posts = new FacebookPosts(getAccessToken(), uid+'/posts');		
			action = 'getPosts';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getTaggedData(){
		try {
			posts = new FacebookPosts(getAccessToken(), uid+'/tagged');		
			action = 'getTagged';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getLikesData(){
		try {
			likes = new FacebookLikes(getAccessToken(), uid+'/likes');
			action = 'getLikes';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getActivitiesData(){
		try {
			refs = new FacebookRefs(getAccessToken(), uid+'/activities');
			action = 'getActivities';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getMoviesData(){
		try {
			refs = new FacebookRefs(getAccessToken(), uid+'/movies');
			action = 'getMovies';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getBooksData(){
		try {
			refs = new FacebookRefs(getAccessToken(), uid+'/books');
			action = 'getBooks';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getInterestsData(){
		try {
			refs = new FacebookRefs(getAccessToken(), uid+'/interests');		
			action = 'getInterests';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getTelevisionData(){
		try {
			refs = new FacebookRefs(getAccessToken(), uid+'/television');
			action = 'getTelevision';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getMusicData(){
		try {
			refs = new FacebookRefs(getAccessToken(), uid+'/music');
			action = 'getMusic';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getGroupsData(){
		try {
			groups = new FacebookGroups(getAccessToken(), uid+'/groups');
			action = 'getGroups';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getStatusesData(){
		try {
			statuses = new FacebookStatusMessages(getAccessToken(), uid+'/statuses');
			action = 'getStatuses';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getEventsData(){
		try {
			events = new FacebookEvents(getAccessToken(), uid+'/events');		
			action = 'getEvents';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getNotesData(){
		try {
			notes = new FacebookNotes(getAccessToken(), uid+'/notes');		
			action = 'getNotes';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void getLinksData(){
		try {
			links = new FacebookLinks(getAccessToken(), uid+'/links');
			action = 'getLinks';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void searchPosts(){
		try {
			posts = FacebookPosts.search(getAccessToken(), uid);
			action = 'getPosts';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void searchUsers(){
		try {
			users = FacebookUsers.search(getAccessToken(), uid);
			action = 'getUsers';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void searchPages(){
		try {
			pages_z = FacebookPages.search(getAccessToken(), uid);
			action = 'getPages';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void searchEvents(){
		try {
			events = FacebookEvents.search(getAccessToken(), uid);
			action = 'getEvents';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void searchGroups(){
		try {
			groups = FacebookGroups.search(getAccessToken(), uid);
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

			places = FacebookPlaces.search(getAccessToken(), uid, params);
			action = 'getPlaces';
		} catch (Exception e) {
			errorMessage = e.getMessage();
			action = 'error';
		} 
	}
	
	public void searchCheckins(){
		try {
			// Checkins doesn't support search on a query
			checkins = FacebookCheckins.search(getAccessToken());
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