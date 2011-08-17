/**
 * @author Pat Patterson - ppatterson@salesforce.com
 */

global class FacebookHousekeeping implements Schedulable {
    global void execute(SchedulableContext sc) {
    	List<FacebookSession__c> sessions = 
    	   [select Id from FacebookSession__c where (Expiry__c < :DateTime.now())];
        delete sessions;
    }
}