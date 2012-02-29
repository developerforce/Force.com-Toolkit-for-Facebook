public with sharing class FacebookCrypto {
	// Throw an exception if user does not have 'Customize Application' perm
	private static void checkUserCanCustomizeApplication() {
		User user = [SELECT Id, ProfileId 
					 FROM User 
					 WHERE Id = :UserInfo.getUserId() LIMIT 1];

		List<Profile> profile = [SELECT Id 
						   FROM Profile 
						   WHERE Id = :user.ProfileId AND PermissionsCustomizeApplication = true];
		
		if (profile.size() > 0) {
			return;
		}
		
		List<PermissionSet> permSets = 
			[SELECT Id 
			 FROM PermissionSet
			 WHERE PermissionsCustomizeApplication = true AND 
			 	Id IN (SELECT PermissionSetId 
					   FROM PermissionSetAssignment 
					   WHERE AssigneeId = :user.Id)];
													 
		if (permSets.size() > 0) {
			return;
		}	
		
		throw new FacebookException('User does not have permission to set encryption key');	
	}
	
    public static String decrypt(String data) {
        EncryptionSettings__c settings = EncryptionSettings__c.getOrgDefaults();
        if (settings.key__c == null) {
            throw new FacebookException('Cannot decrypt without a key!');
        }
        Blob key = EncodingUtil.base64Decode(settings.key__c);
        return Crypto.decryptWithManagedIV('AES256', key, EncodingUtil.base64Decode(data)).toString();
    }

    public static String encrypt(String data) {
        EncryptionSettings__c settings = EncryptionSettings__c.getOrgDefaults();
        Blob key = null;
        if (settings.key__c == null) {
        	checkUserCanCustomizeApplication();
            key = Crypto.generateAesKey(256);
            settings.key__c = EncodingUtil.base64Encode(key);
            insert settings;
        } else {
            key = EncodingUtil.base64Decode(settings.key__c);
        }
        return EncodingUtil.base64Encode(Crypto.encryptWithManagedIV('AES256', key, Blob.valueOf(data)));
    }
}