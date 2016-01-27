# Force.com Toolkit for Facebook

The Force.com Toolkit for Facebook allows your Force.com apps to manipulate the Facebook [Graph API](https://developers.facebook.com/docs/reference/api/). The toolkit provides a set of Apex classes, such as `FacebookUser` and `FacebookPost`, that model Facebook Graph API Objects such as `User` and `Post`.

There is a sample deployment of the toolkit at https://testfbtk3-developer-edition.na14.force.com/ - you can visit this Force.com Site, login via Facebook, and see the toolkit in action. All the code behind the sample site is included in the toolkit.

## Changes in version 3.4

* Added sample code to FacebookInboxPage to show how to send Facebook Messages using the [Facebook SDK for JavaScript](https://developers.facebook.com/docs/javascript)
* Better error handling during OAuth flow
* Access Token field in Facebook Session object is now 1024 bytes
* Updated Permissions picklist in Facebook App to match [Facebook Permissions Reference](https://developers.facebook.com/docs/facebook-login/permissions)  

[Older Changes](OlderChanges.md)

## Installation

There are two mechanisms for installing the toolkit: as an unmanaged package, or from GitHub. Choose the unmanaged package if you will be using the toolkit to develop your own Facebook app. If you are considering modifying or extending the toolkit itself, then installing from GitHub is a little more work, but will enable you to easily contribute code back to the project.

### Installing the Unmanaged Package

1. Create a new Developer Edition (DE) account at http://developer.force.com/join. You will receive an activation email - click the enclosed link to complete setup of your DE environment. This will also log you in to your new DE environment.
2. Install the unmanaged package into your new DE org via this URL: https://login.salesforce.com/packaging/installPackage.apexp?p0=04td00000001q8m
3. Click through the screens to complete installation.

### Installing from GitHub

1. Create a new Developer Edition (DE) account at http://developer.force.com/join. You will receive an activation email - click the enclosed link to complete setup of your DE environment. This will also log you in to your new DE environment.
2. Create a new Force.com project in the [Force.com IDE](http://wiki.developerforce.com/index.php/Force.com_IDE) using your new org's credentials. In the 'Choose Initial Project Contents' dialog, select 'Selected metadata components', hit 'Choose...' and select ALL of the components in the next page. This will give you a complete project directory tree.
3. Clone this GitHub project into the Force.com IDE project directory. You will need to clone it first to a temporary location, since git will not let you clone to a directory with existing content:

        $ git clone --no-checkout git://github.com/developerforce/Force.com-Toolkit-for-Facebook.git /path/to/your/projectdir/tmp
        $ mv /path/to/your/projectdir/tmp/.git /path/to/your/projectdir
        $ rm -rf /path/to/your/projectdir/tmp
        $ cd /path/to/your/projectdir
        $ git reset --hard HEAD

4. In Eclipse, right click your project in the project explorer and click 'Refresh'. This causes Eclipse to scan the project directory tree for changes, and the plugin syncs changes to Force.com.
5. In your DE environment, go to **Setup | App Setup | Create | Apps**, click 'Edit' next to the Facebook Toolkit 3 app, scroll down, click the 'Visible' box next to System Administrator and hit 'Save'. Now go to **Setup | Administration Setup | Manage Users | Profiles**, click on 'Edit' next to System Administrator, scroll down to Custom Tab Settings, set 'Facebook Apps', 'Facebook Social Samples', 'Facebook Sessions' and 'Facebook User Connections Test' to 'Default On' and hit 'Save'. 'Facebook Toolkit 3' should now be available in the dropdown list of apps (top right).
6. Go to **Setup | Administration Setup | Security Controls | Remote Site Settings** and add https://graph.facebook.com as a new remote site.

## Configuring the Sample Force.com Site

1. Go to **Setup | App Setup | Develop | Sites** and create a new site. Set the home page to `FacebookToolkitPage` and add `FacebookCallback`, `FacebookInboxPage`, `FacebookSamplePage` and `FacebookTestUser` to the list of Site Visualforce Pages. Ensure you activate the site.
2. Go to **Setup | App Setup | Develop | Apex Classes**, hit the 'Compile All Classes' link, then click 'Schedule Apex' and add `FacebookHousekeeping` - set it to run at midnight every night. This scheduled Apex job will remove expired session records from the FacebookSession__c object.
3. Go to the [Facebook Apps Page](https://developers.facebook.com/apps), click 'Create New App' and complete the required fields. Under 'Website', set Site URL to your site's secure URL - for example, https://fbtest-developer-edition.na14.force.com/
4. In your DE environment, select the 'Facebook Toolkit 3' app from the application menu at top right, then click the 'Facebook Apps' tab. Create a new Facebook app, copying 'App ID' from your new app's settings in Facebook. Set 'Permissions' to allow the sample app to access more data; for example, you might use `read_stream, publish_stream` to allow the app to read and write posts on the user's feed. See the [Facebook Graph API documentation](https://developers.facebook.com/docs/reference/api/permissions/) for a full discussion of permissions. Note that, after you save the Facebook App record, you must click the 'Set App Secret' button to enter the 'App Secret' from your new app's settings in Facebook.
5. Go to your site URL (e.g. https://fbtest-developer-edition.na14.force.com/) and you should be prompted to log in to your new app. Do so and you should see a sample page showing your Facebook user name, profile picture, feed, 'Like' button etc. There are buttons to dynamically retrieve your user profile and friends list.
6. Now you have the sample pages working, you have a starting point for a Facebook app running on Force.com. Examine `FacebookSamplePage` and `FacebookSampleController` to see how the sample app is put together.

## Developing a Facebook App with the Toolkit

Every Facebook Graph API call must be accompanied by an *access token*; the access token authorizes your app to access the Graph API on behalf of the authenticated user. Facebook uses the [OAuth 2.0](http://oauth.net/2/) protocol for authentication and authorization. Your app must send users to Facebook to log in and authorize your app to access the Graph API on the users' behalf. There are two ways of doing this, depending on whether you want to map Facebook users to identities in salesforce.com.

### No Mapping

You can implement your app as a Force.com Site, in which, as far as the Force.com platform is concerned, all users are mapped to a single Site Guest user. You must manage any user-related data yourself, typically indexed by users' Facebook IDs, and you must use the `FacebookLoginController` supplied with the toolkit as a base class for your app's controllers. `FacebookLoginController` manages the OAuth 2.0 interaction with Facebook, randomly generates a session cookie for the user, and maintains a `FacebookSession` custom object mapping session cookies to Facebook access tokens. Your Visualforce pages must set their action attribute to the controller's login method so that `FacebookLoginController` can obtain the access token:

    <apex:page controller="FacebookSampleController" action="{!login}" 
      cache="false" sidebar="false" showHeader="false" 
      title="Force.com Toolkit for Facebook - Sample Page">

Your controller code can now retrieve the current user's token with `FacebookToken.getAccessToken()`.

### Map Facebook Accounts to Salesforce Users

Alternatively, from Spring ’12 onwards, you can implement your app within a Salesforce org or portal. In this case, each Facebook account is mapped to a unique user within your Salesforce org. [Social Single Sign-On – Authentication Providers in Spring ’12](http://blogs.developerforce.com/developer-relations/2012/01/social-single-sign-on-authentication-providers-in-spring-12.html) gives an overview of configuring Facebook as an *Authentication Provider* and linking existing salesforce.com users’ accounts to their Facebook accounts, or creating new accounts for users arriving from Facebook.

If you are using the Facebook Authentication Provider, you need not use `FacebookLoginController`; the platform will manage interaction with Facebook for you. Your Apex code can retrieve the current user’s token with `Auth.AuthToken.getAccessToken(AuthProviderID, AuthProviderType);`.

### Accessing the Graph API

However you obtain the access token, accessing the API follows the same pattern. You can retrieve most Facebook Graph API objects by calling the relevant constructor with the access token and an id (for example, `me`) or connection (for example, `me/friends`) and an optional map of API parameters.

So, to retrieve the `User` object for a user with Facebook ID 1111111111:

    FacebookUser user = new FacebookUser(access_token, '1111111111');
    
and to retrieve a list of friends, including their hometowns, for the currently authenticated user:

    Map<String,String> params = new Map<string,string>{'fields' => 'id,name,hometown'};
    FacebookUsers friends = new FacebookUsers(access_token, 'me/friends', params);

Note that your app is limited to the data to which the authenticated user and other users have granted access.

Once your app has retrieved a Graph API object, it can manipulate it in Apex or Visualforce using its Apex properties. Here a Visualforce page iterated through the friends object obtained above:

    <apex:pageBlockTable value="{!friends.data}" var="friend">
        <apex:column value="{!friend.id}" headerValue="Id"/> 
        <apex:column value="{!friend.name}" headerValue="Name"/>
        <apex:column value="{!friend.hometown.name}" headerValue="Hometown"/>
    </apex:pageBlockTable>

You can see many similar examples in the sample pages and controllers:

* `FacebookSamplePage`
* `FacebookSampleController`
* `FacebookTestUser`
* `FacebookTestUserController`

### Security Considerations

The toolkit AES-256 encrypts secrets at rest (Facebook application client secrets and user access tokens), dynamically creating a key on first use and saving that key in a protected custom setting. As a result, these secrets are secure when the toolkit is used in a managed package - the key is inaccessible outside the package, and can only be created when a user with the 'Customize Application' permission (for example, a user with the System Administrator profile) creates the first Facebook App record.

Note that, if the toolkit is used outside a managed package, these secrets are accessible to any users that can access the custom setting, either directly in the console, or indirectly via Apex code.

For more information, see the [getting started guide](http://wiki.developerforce.com/page/Getting_Started_with_the_Force.com_Toolkit_for_Facebook,_Version_3.0).