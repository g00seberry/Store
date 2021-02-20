public class Util {
    public static String GetUserIPAddress() {
    	Map<String, String> session = Auth.SessionManagement.getCurrentSession();
    	return session.get('SourceIp');
    }
    
    public static String EncryptString(String value){
        Blob hash = Crypto.generateDigest('SHA-256', Blob.valueOf(value));
        return EncodingUtil.base64Encode(hash);
    }
}