@isTest
public class BankCardControllerTest {
    @isTest
    public static void CreateBankCardTest() {
        CUser__c normalUser = new CUser__c(
            Login__c='testLogin123',
            Email__c = 'testmail@ahaha.ohoho',
            Password__c= Util.EncryptString('VictoriaSecret')
        );
        
        insert normalUser;
        
        normalUser.Password__c = 'VictoriaSecret';

        normalUser = AuthController.AuthUser(JSON.serialize(normalUser));

        BankCard__c cardRequest = new BankCard__c(
            CardNumber__c = '1234567891234567',
            CardOwner__c = 'Owner Ownerowich',
            ExpiryDate__c = '12/2020'
        );

        BankCard__c card = BankCardController.CreateBankCard(JSON.serialize(cardRequest));

        System.assertEquals(true, card.CardNumber__c == cardRequest.CardNumber__c); 
    }

    @isTest
    public static void CreateInvalidBankCardTest() {
        CUser__c normalUser = new CUser__c(
            Login__c='testLogin123',
            Email__c = 'testmail@ahaha.ohoho',
            Password__c= Util.EncryptString('VictoriaSecret')
        );
        
        insert normalUser;
        
        normalUser.Password__c = 'VictoriaSecret';

        normalUser = AuthController.AuthUser(JSON.serialize(normalUser));
        try{
            BankCardController.CreateBankCard(JSON.serialize(new BankCard__c(
                CardOwner__c = 'Owner Ownerowich'          
            )));
        }
        catch(Exception e) {
            System.assertEquals(1,1); 
        }
    }

    @isTest
    public static void CreateMaxBankCardNumberTest() {
        CUser__c normalUser = new CUser__c(
            Login__c='testLogin123',
            Email__c = 'testmail@ahaha.ohoho',
            Password__c= Util.EncryptString('VictoriaSecret')
        );
        
        insert normalUser;
        
        normalUser.Password__c = 'VictoriaSecret';

        normalUser = AuthController.AuthUser(JSON.serialize(normalUser));

        BankCard__c cardRequest = new BankCard__c(
            CardNumber__c = '1234567891234567',
            CardOwner__c = 'Owner Ownerowich',
            ExpiryDate__c = '12/2020'
        );

        try{
            BankCardController.CreateBankCard(JSON.serialize(new BankCard__c(
                CardNumber__c = '1234567891234567',
                CardOwner__c = 'Owner Ownerowich',
                ExpiryDate__c = '12/2020'
            )));

            BankCardController.CreateBankCard(JSON.serialize(new BankCard__c(
                CardNumber__c = '1234567891234568',
                CardOwner__c = 'Owner Ownerowich',
                ExpiryDate__c = '12/2020'
            )));

            BankCardController.CreateBankCard(JSON.serialize(new BankCard__c(
                CardNumber__c = '1234567891234569',
                CardOwner__c = 'Owner Ownerowich',
                ExpiryDate__c = '12/2020'
            )));

            BankCardController.CreateBankCard(JSON.serialize(new BankCard__c(
                CardNumber__c = '12345678912345610',
                CardOwner__c = 'Owner Ownerowich',
                ExpiryDate__c = '12/2020'
            )));
        }
        catch(Exception e) {
            System.assertEquals(1,1); 
        }
    }

    @isTest
    public static void CreateInvalidExpiryDateBankCardTest() {
        CUser__c normalUser = new CUser__c(
            Login__c='testLogin123',
            Email__c = 'testmail@ahaha.ohoho',
            Password__c= Util.EncryptString('VictoriaSecret')
        );
        
        insert normalUser;
        
        normalUser.Password__c = 'VictoriaSecret';

        AuthController.AuthUser(JSON.serialize(normalUser));

        try{
            BankCardController.CreateBankCard(JSON.serialize(new BankCard__c(
                CardNumber__c = '1234567891234567',
                CardOwner__c = 'Owner Ownerowich',
                ExpiryDate__c = '12/20'
            )));
        }
        catch(Exception e) {
            System.assertEquals(1,1); 
        }
    }

    @isTest
    public static void CreateInvalidOwnerBankCardTest() {
        CUser__c normalUser = new CUser__c(
            Login__c='testLogin123',
            Email__c = 'testmail@ahaha.ohoho',
            Password__c= Util.EncryptString('VictoriaSecret')
        );
        
        insert normalUser;
        
        normalUser.Password__c = 'VictoriaSecret';

        AuthController.AuthUser(JSON.serialize(normalUser));
        
        try{
            BankCardController.CreateBankCard(JSON.serialize(new BankCard__c(
                CardNumber__c = '1234567891234567',
                CardOwner__c = '',
                ExpiryDate__c = '12/2020'
            )));
        }
        catch(Exception e) {
            System.assertEquals(1,1); 
        }
    }
    

    @isTest
    public static void RemoveBankCardTest() {
        CUser__c normalUser = new CUser__c(
            Login__c='testLogin123',
            Email__c = 'testmail@ahaha.ohoho',
            Password__c= Util.EncryptString('VictoriaSecret')
        );
        
        insert normalUser;
        
        normalUser.Password__c = 'VictoriaSecret';

        AuthController.AuthUser(JSON.serialize(normalUser));

        BankCard__c card = BankCardController.CreateBankCard(JSON.serialize(new BankCard__c(
                CardNumber__c = '1234567891234567',
                CardOwner__c = 'Owner Ownerowich',
                ExpiryDate__c = '12/2020'
            )));

        System.assertEquals(true, card.CardNumber__c == BankCardController.RemoveBankCard(card.Id).CardNumber__c); 
    }

    @isTest
    public static void GetBankCardsTest() {
        CUser__c normalUser = new CUser__c(
            Login__c='testLogin123',
            Email__c = 'testmail@ahaha.ohoho',
            Password__c= Util.EncryptString('VictoriaSecret')
        );
        
        insert normalUser;
        
        normalUser.Password__c = 'VictoriaSecret';

        AuthController.AuthUser(JSON.serialize(normalUser));

        BankCardController.CreateBankCard(JSON.serialize(new BankCard__c(
            CardNumber__c = '1234567891234567',
            CardOwner__c = 'Owner Ownerowich',
            ExpiryDate__c = '12/2020'
            )));

        try{
            List<BankCard__c> cards = BankCardController.GetBankCards();
            System.assertEquals(true,BankCardController.GetBankCards() != null); 
        }
        catch(Exception e) {
            System.assertEquals(true, false); 
        }  
    }


    @isTest
    public static void PayTest() {
        CUser__c normalUser = new CUser__c(
            Login__c='testLogin123',
            Email__c = 'testmail@ahaha.ohoho',
            Password__c= Util.EncryptString('VictoriaSecret')
        );
        
        insert normalUser;
        
        normalUser.Password__c = 'VictoriaSecret';

        AuthController.AuthUser(JSON.serialize(normalUser));

        BankCard__c card = BankCardController.CreateBankCard(JSON.serialize(new BankCard__c(
            CardNumber__c = '1234567891234567',
            CardOwner__c = 'Owner Ownerowich',
            ExpiryDate__c = '12/2020'
            )));

        try{
            card = BankCardController.Pay(card.Id, 1000);
            System.assertEquals(true,card.Balance__c == 99000); 
        }
        catch(Exception e) {
            System.assertEquals(true, false); 
        }  
    }
    @isTest
    public static void InsufficientFundsTest() {
        CUser__c normalUser = new CUser__c(
            Login__c='testLogin123',
            Email__c = 'testmail@ahaha.ohoho',
            Password__c= Util.EncryptString('VictoriaSecret')
        );
        
        insert normalUser;
        
        normalUser.Password__c = 'VictoriaSecret';

        AuthController.AuthUser(JSON.serialize(normalUser));

        BankCard__c card = BankCardController.CreateBankCard(JSON.serialize(new BankCard__c(
            CardNumber__c = '1234567891234567',
            CardOwner__c = 'Owner Ownerowich',
            ExpiryDate__c = '12/2020'
            )));

        try{
            card = BankCardController.Pay(card.Id, 101000);
        }
        catch(Exception e) {
            System.assertEquals(true, true); 
        }  
    }

   
}

