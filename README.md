Major changes in Version 3
==========================

* There is a new custom object to associate the Facebook access
token with a session cookie.
* The toolkit uses the new native JSON implementation.

Instructions
============

1. Create a new Developer Edition (DE) account at http://developer.force.com/join. You will receive an activation email - click the enclosed link to complete setup of your DE environment. This will also log you in to your new DE environment.
2. Create a new Force.com project in the [Force.com IDE](http://wiki.developerforce.com/index.php/Force.com_IDE) using your new org's credentials. In the 'Choose Initial Project Contents' dialog, select 'Selected metadata components', hit 'Choose...' and select ALL of the components in the next page. This will give you a complete project directory tree.
3. Clone this GitHub project into the Force.com IDE project directory

        $ git clone git://github.com/metadaddy-sfdc/Force.com-Toolkit-for-Facebook.git /path/to/your/projectdir

4. In Eclipse, right click your project in the project explorer and click 'Refresh'. This causes Eclipse to scan the project directory tree for changes, and the plugin syncs changes to Force.com.
5. In your DE environment, go to **Setup | App Setup | Create | Apps**, click 'Edit' next to the Facebook Toolkit 3 app, scroll down, click the 'Visible' box next to System Administrator and hit 'Save'. Now go to **Setup | Administration Setup | Manage Users | Profiles**, click on 'Edit' next to System Administrator, scroll down to Custom Tab Settings, set 'Facebook Apps', 'Facebook Social Samples', 'Facebook Sessions' and 'Facebook User Connections Test' to 'Default On' and hit 'Save'. 'Facebook Toolkit 3' should now be available in the dropdown list of apps (top right).
6. Go to **Setup | Administration Setup | Security Controls | Remote Site Settings** and add https://graph.facebook.com as a new remote site.
7. Go to **Setup | App Setup | Develop | Sites** and create a new site with FacebookSamplePage as its home page. Ensure you activate the site.
8. Go to **Setup | App Setup | Develop | Apex Classes**, hit the 'Compile All Classes' link, then click 'Schedule Apex' and add FacebookHousekeeping - set it to run at midnight every night. This scheduled Apex job will remove expired session records from the FacebookSession__c object.
9. Go to the [Facebook Apps Page](https://developers.facebook.com/apps), click 'Create New App' and complete the required fields. Under 'Website', set Site URL to your site's secure URL - for example, https://fbtest-developer-edition.na14.force.com/
10. In your DE environment, select the 'Facebook Toolkit 3' app from the application menu at top right, then click the 'Facebook Apps' tab. Create a new Facebook app, copying 'App ID' and 'App Secret' from your new app's settings in Facebook.
11. Go to your site URL (e.g. https://fbtest-developer-edition.na14.force.com/) and you should be prompted to log in to your new app. Do so and you should see a sample page showing your Facebook user info, profile picture, 'Like' button etc.

Now you have the sample page working, you have a starting point for a Facebook app running on Force.com.

For more information, see the getting started guide.

http://wiki.developerforce.com/index.php/Getting_Started_with_the_new_Facebook_Toolkit
