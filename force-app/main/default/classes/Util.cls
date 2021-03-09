public class Util {
    public static String GetUserIPAddress() {
        if(Test.isRunningTest()){
            return '192.168.1.1';
        }
        else{
            Map<String, String> session = Auth.SessionManagement.getCurrentSession();
            return session.get('SourceIp');
        }
    }
    
    public static String EncryptString(String value){
        Blob hash = Crypto.generateDigest('SHA-256', Blob.valueOf(value));
        return EncodingUtil.base64Encode(hash);
    }
}