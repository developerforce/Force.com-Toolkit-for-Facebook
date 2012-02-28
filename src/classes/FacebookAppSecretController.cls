public with sharing class FacebookAppSecretController {
    private FacebookApp__c app;
    
    public FacebookAppSecretController(ApexPages.StandardController controller) {
        this.app = (FacebookApp__c)controller.getRecord();
    }   

    public String getSecret() {
        return null;
    }
    
    public void setSecret(String secret) {
        app.clientSecret__c = FacebookCrypto.encrypt(secret);
    }
}