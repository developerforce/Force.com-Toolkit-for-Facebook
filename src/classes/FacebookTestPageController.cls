public  class FacebookTestPageController {
/*	
	public String clientID { get; set; }
	public String albumID { get; set; }
	public String username { get; set; }
	public String reqType { get; set; }
	public String response { get; set; }
	
	public String nextPage { get; set; }
	public String prevPage { get; set; }
	
	
	public FacebookTestPageController() 
	{
		username = 'qwall';
		clientID = '136520473033312'; //sample facebook app you can use for testing
		albumID = '99394368305'; //coca-cola sample album
	}
	
	//assumes client has already been authenticated.
	public PageReference doTest() {
		if(reqType == 'likes')
		{
			FacebookLikes fbl = new FacebookLikes(clientID, username, null);
			response = fbl.jsonstring;
		}
		else if(reqType == 'friends')
		{
			FacebookFriends fbl = new FacebookFriends(clientID, username, null);
			response = fbl.jsonstring;
		}
		else if(reqType == 'me')
		{
			FacebookUser fbl = new FacebookUser(clientID, username, null);
			response = fbl.jsonstring;
		}
		else if(reqType == 'photos')
		{
			FacebookPhotos fbl = new FacebookPhotos(clientID, username, null);
			response = fbl.jsonstring; 
		}
		else if(reqType == 'album')
		{
			FacebookAlbums fbl = new FacebookAlbums();
			fbl.getAlbumById(clientId,albumId,null);
			response = fbl.jsonstring; 
		}
		else if(reqType == 'albums')
		{
			FacebookAlbums fbl = new FacebookAlbums(clientId,username,null);
			response = fbl.jsonstring; 
		}
		else if(reqType == 'groups')
		{
			FacebookGroups fbl = new FacebookGroups(clientID, username, null);
			response = fbl.jsonstring; 
		}
		else if(reqType == 'movies')
		{
			FacebookMovies fbl = new FacebookMovies(clientID, username, null);
			response = fbl.jsonstring; 
		}
		else if(reqType == 'books')
		{
			FacebookBooks fbl = new FacebookBooks(clientID, username, null);
			response = fbl.jsonstring; 
		}
		else if(reqType == 'events')
		{
			FacebookEvents fbl = new FacebookEvents(clientID, username, null);
			response = fbl.jsonstring; 
			this.prevPage = fbl.prevPage;
			this.nextPage = fbl.nextPage;
		}
		else if(reqType == 'home')
		{
			FacebookHome fbl = new FacebookHome(clientID, username, null);
			response = fbl.jsonstring; 
			this.prevPage = fbl.prevPage;
			this.nextPage = fbl.nextPage;
			
			if(fbl.nextPage != null){
				response += '\n\n # Next Page # \n\n';
				fbl.getNextPage();
				response += fbl.jsonstring;
			}
		}
		else if(reqType == 'feed')
		{
			FacebookFeed fbl = new FacebookFeed(clientID, username, null);
			response = fbl.jsonstring; 
			this.prevPage = fbl.prevPage;
			this.nextPage = fbl.nextPage;
		}
		else if(reqType == 'videos')
		{
			FacebookVideos fbl = new FacebookVideos(clientID, username, null);
			response = fbl.jsonstring; 
		}
		else if(reqType == 'notes')
		{
			FacebookNotes fbl = new FacebookNotes(clientID, username, null);
			response = fbl.jsonstring; 
		}
		return null;
	}
	
	public List<SelectOption> getReqItems() {
		List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('me','me')); //implemented
        options.add(new SelectOption('books','books')); //complete with tests
        options.add(new SelectOption('likes','likes')); //complete with tests
        options.add(new SelectOption('friends','friends')); //complete with tests
        options.add(new SelectOption('movies','movies')); //complete with tests
        options.add(new SelectOption('albums','albums'));  //this is the complete example with test methods
         options.add(new SelectOption('album','album by id'));  //
        options.add(new SelectOption('home','home ')); // need to test 100% , currently lower 
        options.add(new SelectOption('feed','feed'));  // need to test 100% , currently lower 
        options.add(new SelectOption('videos','videos (needs Extended Permissions)')); 
        options.add(new SelectOption('photos','photos (needs Extended Permissions)')); 
        options.add(new SelectOption('notes','notes (needs Extended Permissions)')); 
        options.add(new SelectOption('events','events (needs Extended Permissions)')); //complete with tests, not working on the page.
       	options.add(new SelectOption('groups','groups (needs Extended Permissions)')); //complete with tests, not working on the page.
       	//options.add(new SelectOption('profilepic','profilepic')); //implemented but not supported in this test controller
       
        return options;
    }*/
}