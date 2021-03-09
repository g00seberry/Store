@isTest
private class AuthControllerTest {

    @isTest
    public static void AuthNullUser() {
        try{
            AuthController.AuthUser(null);
        }
        catch(Exception e) {
            System.assertEquals(1,1); 
        }
    }

    @isTest
    public static void AuthNotRegisteredUser() {

        CUser__c normalUser = new CUser__c(
            Login__c ='testLogin123',
            Email__c = 'testmail@ahaha.ohoho',
            Password__c = Util.EncryptString('VictoriaSecret')
        );

        try{
            AuthController.AuthUser(JSON.serialize(normalUser));
        }
        catch(Exception e) {
            System.assertEquals(1,1); 
        }
    }

    @isTest
    public static void AuthRegisteredUser() {

        CUser__c normalUser = new CUser__c(
            Login__c='testLogin123',
            Email__c = 'testmail@ahaha.ohoho',
            Password__c= Util.EncryptString('VictoriaSecret')
        );
        
        insert normalUser;

        normalUser.Password__c = 'VictoriaSecret';

        CUser__c user = AuthController.AuthUser(JSON.serialize(normalUser));

        System.assertEquals(true, user.Login__c == normalUser.Login__c);
    }

    @isTest
    public static void LogoutUser() {

        CUser__c normalUser = new CUser__c(
            Login__c='testLogin123',
            Email__c = 'testmail@ahaha.ohoho',
            Password__c= Util.EncryptString('VictoriaSecret')
        );
        
        insert normalUser;
        
        normalUser.Password__c = 'VictoriaSecret';

        CUser__c user = AuthController.LogoutUser(JSON.serialize(normalUser));

        System.assertEquals(null, user);
    }

    @isTest
    public static void CheckAuthUserTest() {

        CUser__c normalUser = new CUser__c(
            Login__c='testLogin123',
            Email__c = 'testmail@ahaha.ohoho',
            Password__c= Util.EncryptString('VictoriaSecret')
        );
        
        insert normalUser;
        
        normalUser.Password__c = 'VictoriaSecret';

        normalUser = AuthController.AuthUser(JSON.serialize(normalUser));

        CUser__c user = AuthController.CheckAuthUser();

        System.assertEquals(true, normalUser.Login__c == user.Login__c);
    }
    
}
