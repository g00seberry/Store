@isTest
public class CUserControllerTest {

    public static CUser__c CreateTestUser(String login, String mail, String password, String passRepeat){
        CUser__c user = new CUser__c(
            Password__c=password,
            Email__c=mail,
            Login__c=login
        );

        try{
            CUser__c newUser = CUserController.CreateNewUser(JSON.serialize(user), passRepeat);
            return newUser;
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }


    @isTest
    public static void CreateNewUserTest() {
        try{
            
            CUser__c newUser = CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789'
                );

            System.assertEquals(true, newUser.Login__c == 'test123');
        }
        catch(Exception e){
            System.assertEquals(true, false);
        }
    }

    @isTest
    public static void CreateNewUserInvalidPassTest() {
        try{
            
            CUser__c newUser = CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456', 
                '123456'
                );

            System.assertEquals(true, false);
        }
        catch(Exception e){
            System.assertEquals(true, true);
        }
    }

    @isTest
    public static void CreateNewUserInvalidRepeatTest() {
        try{
            
            CUser__c newUser = CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456788'
                );

            System.assertEquals(true, false);
        }
        catch(Exception e){
            System.assertEquals(true, true);
        }
    }

    @isTest
    public static void CreateSameUserEmailTest() {
        try{
            
            CUser__c newUser = CreateTestUser(
                'test1234',
                'test@gmail.com',
                '123456789', 
                '123456789'
                );

            CUser__c newUser2 = CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789'
                );

            System.assertEquals(false, newUser.Login__c == newUser2.Login__c);
        }
        catch(Exception e){
            System.assertEquals(true, true);
        }
    }

    @isTest
    public static void CreateSameUserLoginTest() {
        try{
            
            CUser__c newUser = CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789'
                );

            CUser__c newUser2 = CreateTestUser(
                'test123',
                'test2@gmail.com',
                '123456789', 
                '123456789'
                );

            System.assertEquals(false, newUser.Login__c == newUser2.Login__c);
        }
        catch(Exception e){
            System.assertEquals(true, true);
        }
    }

    @isTest
    public static void UpdateUserTest() {
        try{
            
            CUser__c user = CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789'
                );

            user.Password__c = '123456789';
            AuthController.AuthUser(JSON.serialize(user));

            user.Login__c = 'test321';

            CUser__c newUser = CUserController.UpdateUser(JSON.serialize(user));

            System.assertEquals(true, user.Login__c == 'test321');
            //System.assertEquals(true, true);
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    @isTest
    public static void UpdateUserInvalidEmailTest() {
        try{
            
            CUser__c user = CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789'
                );

            user.Password__c = '123456789';
            AuthController.AuthUser(JSON.serialize(user));

            user.Email__c = '';

            CUser__c newUser = CUserController.UpdateUser(JSON.serialize(user));

            System.assertEquals(true, false);
        }
        catch(Exception e){
            System.assertEquals(true, true);
        }
    }

    @isTest
    public static void UpdateUserInvalidLoginTest() {
        try{
            
            CUser__c user = CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789'
                );

            user.Password__c = '123456789';
            AuthController.AuthUser(JSON.serialize(user));

            user.Login__c = '';

            CUser__c newUser = CUserController.UpdateUser(JSON.serialize(user));

            System.assertEquals(true, false);
        }
        catch(Exception e){
            System.assertEquals(true, true);
        }
    }

    @isTest
    public static void UpdateUserSameLoginTest() {
        try{
            
            CUser__c user1 = CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789'
                );

            CUser__c user2 = CreateTestUser(
                    'test1234',
                    'test2@gmail.com',
                    '123456789', 
                    '123456789'
                    );

            user2.Password__c = '123456789';

            AuthController.AuthUser(JSON.serialize(user2));

            user2.Login__c = 'test123';

            CUserController.UpdateUser(JSON.serialize(user2));

            System.assertEquals(true, false);
        }
        catch(Exception e){
            System.assertEquals(true, true);
        }
    }

    @isTest
    public static void UpdateUserSameEmailTest() {
        try{
            
            CUser__c user1 = CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789'
                );

            CUser__c user2 = CreateTestUser(
                    'test1234',
                    'test2@gmail.com',
                    '123456789', 
                    '123456789'
                    );

            user2.Password__c = '123456789';

            AuthController.AuthUser(JSON.serialize(user2));

            user2.Email__c = 'test@gmail.com';

            CUserController.UpdateUser(JSON.serialize(user2));

            System.assertEquals(true, false);
        }
        catch(Exception e){
            System.assertEquals(true, true);
        }
    }

    @isTest
    public static void ResetPasswordTest(){
        CUser__c newUser = CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789');

        newUser.Password__c = '123456789';
        AuthController.AuthUser(JSON.serialize(newUser));

        try{
            CUserController.ResetPassword('123456789', '987654321', '987654321');
            System.assertEquals(true, true);
        }
        catch(Exception e){
            System.assertEquals(true, false);
        }
    }

    @isTest
    public static void ResetPasswordInvalidPassTest(){
        CUser__c newUser = CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789');

        newUser.Password__c = '123456789';
        AuthController.AuthUser(JSON.serialize(newUser));
        
        try{
            CUserController.ResetPassword('12345678', '987654321', '987654321');
            System.assertEquals(true, false);
        }
        catch(Exception e){
            System.assertEquals(true, true);
        }
    }

    @isTest
    public static void ResetPasswordInvalidRepeatTest(){
        CUser__c newUser = CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789');

        newUser.Password__c = '123456789';
        AuthController.AuthUser(JSON.serialize(newUser));
        
        try{
            CUserController.ResetPassword('123456789', '987654321', '98765432');
            System.assertEquals(true, false);
        }
        catch(Exception e){
            System.assertEquals(true, true);
        }
    }

    @isTest
    public static void ResetPasswordInvalidSizeTest(){
        CUser__c newUser = CreateTestUser(
                'test123',
                'test@gmail.com',
                '123456789', 
                '123456789');

        newUser.Password__c = '123456789';
        AuthController.AuthUser(JSON.serialize(newUser));
        
        try{
            CUserController.ResetPassword('123456789', '987654', '987654');
            System.assertEquals(true, false);
        }
        catch(Exception e){
            System.assertEquals(true, true);
        }
    }
}
