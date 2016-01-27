## Changes in version 3.3

* Added `FacebookCallback` page and associated controller to handle callback from Facebook centrally.
* Added `FacebookCheckUser` custom Visualforce component and associated controller to periodically check that the current user has a valid Facebook session, and log them out of the Force.com app if the Facebook session is no longer valid. Usage:

        <!-- appId - Facebook Application ID -->
        <!-- userId - ID of currently logged in Facebook User -->
        <!-- timeout - Timeout, in seconds -->
        <c:FacebookCheckUser appId="{!appId}" userId="{!me.id}" timeout="60" />

* Added `FacebookMessage` and `FacebookThread` classes - wrap [Message](https://developers.facebook.com/docs/reference/api/message/) and [Thread](https://developers.facebook.com/docs/reference/api/thread/) Graph API Objects.
* Added `FacebookInbox` page and associated controller to show how to view Facebook Messages with the Toolkit. Note that there is no mechanism for apps to *send* Facebook Messages.
* Refactored `FacebookSamplePage` to no longer automatically log the user in. Added a login button, and use of the `FacebookCheckUser` custom component. The previous auth-login functionality can be restored by overriding `FacebookLoginController.getAutoLogin()` to return `false`.
* Added optional `title` attribute to the `FacebookProfilePicture` custom component to specify tooltip text for the image.
* Added new `FacebookToolkitPage`, collecting the sample, user connections and inbox pages into a tab panel.

## Changes in version 3.2

* Secured the Facebook application client secret and user access tokens by encrypting with a key stored as a custom setting.

## Changes in version 3.1

* Minor fixes plus Authentication Providers support.

## Major changes in Version 3

* There is a new custom object, `FacebookSession__c`, that associates the Facebook access token with a session cookie. This allows a Force.com Site to authenticate users via Facebook.
* The toolkit uses the new native JSON implementation, mitigating issues in earlier versions where JSON was parsed in an Apex utility class, which severely limited the amount of data that could be parsed.
