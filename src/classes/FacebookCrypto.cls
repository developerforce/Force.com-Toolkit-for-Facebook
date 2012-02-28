public with sharing class FacebookCrypto {
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
            key = Crypto.generateAesKey(256);
            settings.key__c = EncodingUtil.base64Encode(key);
            insert settings;
        } else {
            key = EncodingUtil.base64Decode(settings.key__c);
        }
        return EncodingUtil.base64Encode(Crypto.encryptWithManagedIV('AES256', key, Blob.valueOf(data)));
    }
}