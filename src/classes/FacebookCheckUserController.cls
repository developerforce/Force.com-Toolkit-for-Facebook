public class FacebookCheckUserController {
    public PageReference logout() {
    	FacebookToken.deleteAccessToken();
    	
    	PageReference pageRef = ApexPages.currentPage();
    	pageRef.setRedirect(true);
    	
    	return pageRef;
    }
}