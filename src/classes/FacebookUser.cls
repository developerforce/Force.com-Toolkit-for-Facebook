/**
 * FacebookUser handles all information and connections of the USER Object in Facebook Graph API.
 * @author Quinton Wall
 * @author Gastón Esmela
 */

public class FacebookUser extends FacebookObject {	
	public String id {get;set;}
	public String name {get;set;}
	public String first_name {get;set;}
	public String last_name {get;set;}
	public String birthday {get;set;}
	public String bio {get;set;}
	public String quotes {get;set;}
	public String link {get;set;}
	public String hometown_id {get;set;}
	public String hometown_name {get;set;}
	public String location_id {get;set;}
	public String location_name {get;set;}
	public String gender {get;set;}
	public String relationship_status {get;set;}
	public String significant_other_id {get;set;}
	public String significant_other_name {get;set;}
	public String website {get;set;}
	public String religion {get;set;}
	public String political {get;set;}
	public Integer timezone {get;set;}
	public String locale {get;set;}
	public String updated_time {get;set;}
	public String email {get;set;}
	
	public List<educationInfo> education {get;set;}
	public List<workInfo> work {get;set;}
	public List<String> interested_in {get;set;}
	public List<String> meeting_for {get;set;}
	
	// Connections results.
	public List<FacebookUser> friends {get;set;}
	public List<FacebookPage> activities {get;set;}
	public List<FacebookPage> books {get;set;}
	public List<FacebookPage> movies {get;set;}
	public List<FacebookPage> likes {get;set;}
	public List<FacebookPage> television {get;set;}
	public List<FacebookPage> interests {get;set;}
	public List<FacebookPage> music {get;set;}
	public List<FacebookPost> home {get;set;}
	public List<FacebookPost> feed {get;set;}
	public List<FacebookPost> tagged {get;set;}
	public List<FacebookPost> posts {get;set;}
	public List<FacebookPhoto> photos {get;set;}
	public List<FacebookAlbum> albums {get;set;}
	public List<FacebookVideo> videos {get;set;}
	public List<FacebookLink> links {get;set;}
	public List<FacebookEvent> events {get;set;}
	public List<FacebookGroup> groups {get;set;}
	public List<FacebookNote> notes {get;set;}
	public List<FacebookStatusMessage> statuses {get;set;}
	
	public class educationInfo{
		public long schoolId {get;set;}
		public String schoolName {get;set;}
		
		public List<concentrationInfo> concentrations {get;set;}
		
		public educationInfo (JSONObject data){
			if(data.getValue('school') != null){
				this.schoolId = data.getValue('school').obj.getValue('id').dnum.longValue();
				this.schoolName = data.getValue('school').obj.getString('name');
			}
			
			JSONObject.value concentrationV = data.getValue('concentration');
			if(concentrationV != null){
				this.concentrations = new List<concentrationInfo>();
				for(Integer i = 0; i < concentrationV.values.size(); i++){
					concentrationInfo c = new concentrationInfo();
					c.id = concentrationV.values[i].obj.getValue('id').dnum.longValue();
					c.name = concentrationV.values[i].obj.getString('name');
					
					this.concentrations.add(c);
				}
			}
		}
	}
	
	public class concentrationInfo{
		public long id {get;set;}
		public String name {get;set;}
	}
	
	public class workInfo{
		public String employerId {get;set;}
		public String employerName {get;set;}
		public String positionId {get;set;}
		public String positionName {get;set;}
		public String start_date {get;set;}
		public String end_date {get;set;}
		
		public workInfo (JSONObject data){
			
			if(data.getValue('employer') != null){
				this.employerId = data.getValue('employer').obj.getString('id');
				this.employerName = data.getValue('employer').obj.getString('name');
			}
			if(data.getValue('position') != null){
				this.positionId = data.getValue('position').obj.getString('id');
				this.positionName = data.getValue('position').obj.getString('name');
			}
			this.start_date = data.getString('start_date');
			this.end_date = data.getString('end_date');
		}
	}
	
	/**
	 * Constructor - Sets id to be used in calls for USER Object. 
	 */
	public FacebookUser(String id){	
		super();
		this.id = id;
	}
	public FacebookUser(JSONObject data){	
		super();
		this.result.data = data;
		this.id = data.getString('id');
		this.parseUser();
	}
	
	/**
	 * Get Profile Pic
	 */
	public String getProfilePicture(){
		this.doAPICall(this.id, 'picture',null);
		
		return this.result.data.getValue('data').values[0].obj.getString('url');
		
	}
	
	
	/**
	 * Gets a user profile info.
	 */
	public void getData(){
		this.getData(null);
	}
	public void getData(Map<string,string> param){
		this.doAPICall(this.id,null,param);
		this.parseUser();
	}
	
	/**
	 * The photos this user is tagged in. Requires the user_photo_video_tags, friend_photo_video_tags and user_photos or friend_photos permissions
	 */
	public void getPhotoData(){
		this.getPhotoData(null);
	}
	public void getPhotoData(Map<string,string> param){
		this.doAPICall(this.id,'photos',param);
		this.photos = this.parsePhotos();
	}
	
	/**
	 * The user's News Feed. Requires the read_stream permission
	 */
	public void getHomeData(){
		this.getHomeData(null);
	}
	public void getHomeData(Map<string,string> param){
		this.doAPICall(this.id,'home',param);
		this.home = this.parsePosts();
	}
	
	/**
	 * The user's wall. Requires the read_stream permission to see non-public posts.
	 */
	public void getFeedData(){
		this.getFeedData(null);
	}
	public void getFeedData(Map<string,string> param){
		this.doAPICall(this.id,'feed',param);
		this.feed = this.parsePosts();
	}
	
	/**
	 * The photos, videos, and posts in which this user has been tagged. Requires the read_stream permission
	 */
	public void getTaggedData(){
		this.getTaggedData(null);
	}
	public void getTaggedData(Map<string,string> param){
		this.doAPICall(this.id,'tagged',param);
		this.tagged = this.parsePosts();
	}
	
	/**
	 * The user's own posts. Requires the read_stream permission to see non-public posts.
	 */
	public void getPostData(){
		this.getPostData(null);
	}
	public void getPostData(Map<string,string> param){
		this.doAPICall(this.id,'posts',param);
		this.posts = this.parsePosts();
	}
	
	/**
	 * The user's friends
	 */
	public void getFriendData(){
		this.getFriendData(null);
	}
	public void getFriendData(Map<string,string> param){
		this.doAPICall(this.id,'friends',param);
		this.friends = this.parseFriends();
	}
	
	/**
	 * The activities listed on the user's profile
	 */
	public void getActivityData(){
		this.getActivityData(null);
	}
	public void getActivityData(Map<string,string> param){
		this.doAPICall(this.id,'activities',param);
		this.activities = this.parsePages();
	}
	
	/**
	 * The books listed on the user's profile
	 */
	public void getBookData(){
		this.getBookData(null);
	}
	public void getBookData(Map<string,string> param){
		this.doAPICall(this.id,'books',param);
		this.books = this.parsePages();
	}
	
	/**
	 * The movies listed on the user's profile
	 */
	public void getMovieData(){
		this.getMovieData(null);
	}
	public void getMovieData(Map<string,string> param){
		this.doAPICall(this.id,'movies',param);
		this.movies = this.parsePages();
	}
	
	/**
	 * The interests listed on the user's profile
	 */
	public void getInterestData(){
		this.getInterestData(null);
	}
	public void getInterestData(Map<string,string> param){
		this.doAPICall(this.id,'interests',param);
		this.interests = this.parsePages();
	}
	
	/**
	 * The television listed on the user's profile
	 */
	public void getTelevisionData(){
		this.getTelevisionData(null);
	}
	public void getTelevisionData(Map<string,string> param){
		this.doAPICall(this.id,'television',param);
		this.television = this.parsePages();
	}
	
	/**
	 * The music listed on the user's profile
	 */
	public void getMusicData(){
		this.getMusicData(null);
	}
	public void getMusicData(Map<string,string> param){
		this.doAPICall(this.id,'music',param);
		this.music = this.parsePages();
	}
	
	/**
	 * All the pages this user has liked. Requires the user_likes or friend_likes permission
	 */
	public void getLikeData(){
		this.getLikeData(null);
	}
	public void getLikeData(Map<string,string> param){
		this.doAPICall(this.id,'likes',param);
		this.likes = this.parsePages();
	}
	
	/**
	 * The photo albums this user has created. Requires the user_photos or friend_photos permission
	 */
	public void getAlbumData(){
		this.getAlbumData(null);
	}
	public void getAlbumData(Map<string,string> param){
		this.doAPICall(this.id,'albums',param);
		this.albums = this.parseAlbums();
	}

	/**
	 * The videos this user has been tagged in. Requires the user_videos or friend_videos permission.
	 */
	public void getVideoData(){
		this.getVideoData(null);
	}
	public void getVideoData(Map<string,string> param){
		this.doAPICall(this.id,'videos',param);
		this.videos = this.parseVideos();
	}
	
	/**
	 * The groups this user is a member of. Requires the user_groups or friend_groups permission
	 */
	public void getGroupData(){
		this.getGroupData(null);
	}
	public void getGroupData(Map<string,string> param){
		this.doAPICall(this.id,'groups',param);
		this.groups = this.parseGroups();
	}
	
	/**
	 * The user's status updates. Requires the read_stream permission
	 */
	public void getStatusData(){
		this.getStatusData(null);
	}
	public void getStatusData(Map<string,string> param){
		this.doAPICall(this.id,'statuses',param);
		this.statuses = this.parseStatusMessages();
	}
	
	/**
	 * The user's posted links. Requires the read_stream permission
	 */
	public void getLinkData(){
		this.getLinkData(null);
	}
	public void getLinkData(Map<string,string> param){
		this.doAPICall(this.id,'links',param);
		this.links = this.parseLinks();
	}
	
	/**
	 * The user's notes. Requires the read_stream permission
	 */
	public void getNoteData(){
		this.getNoteData(null);
	}
	public void getNoteData(Map<string,string> param){
		this.doAPICall(this.id,'notes',param);
		this.notes = this.parseNotes();
	}
	
	/**
	 * The events this user is attending. Requires the user_events or friend_events permission
	 */
	public void getEventData(){
		this.getEventData(null);
	}
	public void getEventData(Map<string,string> param){
		this.doAPICall(this.id,'events',param);
		this.events = this.parseEvents();
	}
		
	/**
	 * JSON Parsing.
	 */
	public void parseUser(){
		this.name = this.result.data.getString('name');
		this.first_name = this.result.data.getString('first_name');
		this.last_name = this.result.data.getString('last_name');
		this.bio = this.result.data.getString('bio');
		this.quotes = this.result.data.getString('quotes');
		this.link = this.result.data.getString('link');
		this.gender = this.result.data.getString('gender');
		this.relationship_status = this.result.data.getString('relationship_status');
		this.website = this.result.data.getString('website');
		this.birthday = this.result.data.getString('birthday');
		this.religion = this.result.data.getString('religion');
		this.political = this.result.data.getString('political');
		this.updated_time = this.result.data.getString('updated_time');
		this.locale = this.result.data.getString('locale');
		this.email = this.result.data.getString('email');
		
		if(this.result.data.getValue('timezone') != null)
			this.timezone = this.result.data.getValue('timezone').num;
		
		if(this.result.data.getValue('significant_other') != null){
			this.significant_other_id = ''+this.result.data.getValue('significant_other').obj.getValue('id').dnum.longValue();
			this.significant_other_name = this.result.data.getValue('significant_other').obj.getString('name');
		}
		
		if(this.result.data.getValue('hometown') != null){
			this.hometown_id = ''+this.result.data.getValue('hometown').obj.getValue('id').dnum.longValue();
			this.hometown_name = this.result.data.getValue('hometown').obj.getString('name');
		}
		
		if(this.result.data.getValue('location') != null){
			this.location_id = ''+this.result.data.getValue('location').obj.getValue('id').dnum.longValue();
			this.location_name = this.result.data.getValue('location').obj.getString('name');
		}
		
		JSONObject.value interested = this.result.data.getValue('interested_in');
		if(interested != null){
			this.interested_in = new List<String>();
			for(Integer i = 0; i < interested.values.size(); i++){
				this.interested_in.add(interested.values[i].str);
			}
		}
		
		JSONObject.value meeting = this.result.data.getValue('meeting_for');
		if(meeting != null){
			this.meeting_for = new List<String>();
			for(Integer i = 0; i < meeting.values.size(); i++){
				this.meeting_for.add(meeting.values[i].str);
			}
		}
		
		JSONObject.value workV = this.result.data.getValue('work');
		if(workV != null){
			this.work = new List<workInfo>();
			for(Integer i = 0; i < workV.values.size(); i++){
				workInfo w = new workInfo(workV.values[i].obj);
				this.work.add(w);
			}
		}
		
		JSONObject.value eduV = this.result.data.getValue('education');
		if(eduV != null){
			this.education = new List<educationInfo>();
			for(Integer i = 0; i < eduV.values.size(); i++){
				educationInfo e = new educationInfo(eduV.values[i].obj);
				this.education.add(e);
			}
		}
		
	}
	
	public List<FacebookUser> parseFriends(){
		List<FacebookUser> friends = new List<FacebookUser>();
		
		JSONObject.value[] vals =  this.result.data.getValue('data').values;
		for(Integer i = 0; i < vals.size(); i++) {
			FacebookUser friend = new FacebookUser(vals[i].obj);
			friends.add(friend);
		}
		
		return friends;
	}
	
	public List<FacebookPage> parsePages(){
		List<FacebookPage> pages = new List<FacebookPage>();		
		
		JSONObject.value[] vals =  this.result.data.getValue('data').values;
		for(Integer i = 0; i < vals.size(); i++) {
			FacebookPage page = new FacebookPage(vals[i].obj);
			pages.add(page);
		}
		
		return pages;
	}
	
	public List<FacebookPost> parsePosts(){
		List<FacebookPost> posts = new List<FacebookPost>();		
		
		JSONObject.value[] vals =  this.result.data.getValue('data').values;
		for(Integer i = 0; i < vals.size(); i++) {
			FacebookPost post = new FacebookPost(vals[i].obj);
			posts.add(post);
		}
		
		return posts;
	}
	
	public List<FacebookPhoto> parsePhotos() {
		List<FacebookPhoto> photos = new List<FacebookPhoto>();		
		
		JSONObject.value[] vals =  this.result.data.getValue('data').values;
		for(Integer i = 0; i < vals.size(); i++) {
			FacebookPhoto photo = new FacebookPhoto(vals[i].obj);
			photos.add(photo);
		}
		
		return photos;
	}
	
	public List<FacebookAlbum> parseAlbums() {
		List<FacebookAlbum> albums = new List<FacebookAlbum>();		
		
		JSONObject.value[] vals =  this.result.data.getValue('data').values;
		for(Integer i = 0; i < vals.size(); i++) {
			FacebookAlbum album = new FacebookAlbum(vals[i].obj);
			albums.add(album);
		}
		
		return albums;
	}
	
	public List<FacebookVideo> parseVideos() {
		List<FacebookVideo> videos = new List<FacebookVideo>();		
		
		JSONObject.value[] vals =  this.result.data.getValue('data').values;
		for(Integer i = 0; i < vals.size(); i++) {
			FacebookVideo vid = new FacebookVideo(vals[i].obj);
			videos.add(vid);
		}
		
		return videos;
	}
	
	public List<FacebookGroup> parseGroups() {
		List<FacebookGroup> rlist = new List<FacebookGroup>();		
		
		JSONObject.value[] vals =  this.result.data.getValue('data').values;
		for(Integer i = 0; i < vals.size(); i++) {
			FacebookGroup obj = new FacebookGroup(vals[i].obj);
			rlist.add(obj);
		}
		
		return rlist;
	}
	
	public List<FacebookEvent> parseEvents() {
		List<FacebookEvent> rlist = new List<FacebookEvent>();		
		
		JSONObject.value[] vals =  this.result.data.getValue('data').values;
		for(Integer i = 0; i < vals.size(); i++) {
			FacebookEvent obj = new FacebookEvent(vals[i].obj);
			rlist.add(obj);
		}
		
		return rlist;
	}
	
	public List<FacebookNote> parseNotes() {
		List<FacebookNote> rlist = new List<FacebookNote>();		
		
		JSONObject.value[] vals =  this.result.data.getValue('data').values;
		for(Integer i = 0; i < vals.size(); i++) {
			FacebookNote obj = new FacebookNote(vals[i].obj);
			rlist.add(obj);
		}
		
		return rlist;
	}
	
	public List<FacebookLink> parseLinks() {
		List<FacebookLink> rlist = new List<FacebookLink>();		
		
		JSONObject.value[] vals =  this.result.data.getValue('data').values;
		for(Integer i = 0; i < vals.size(); i++) {
			FacebookLink obj = new FacebookLink(vals[i].obj);
			rlist.add(obj);
		}
		
		return rlist;
	}
	
	public List<FacebookStatusMessage> parseStatusMessages() {
		List<FacebookStatusMessage> rlist = new List<FacebookStatusMessage>();		
		
		JSONObject.value[] vals =  this.result.data.getValue('data').values;
		for(Integer i = 0; i < vals.size(); i++) {
			FacebookStatusMessage obj = new FacebookStatusMessage(vals[i].obj);
			rlist.add(obj);
		}
		
		return rlist;
	}
}