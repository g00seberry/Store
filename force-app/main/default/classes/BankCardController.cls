public with sharing class BankCardController {
    @AuraEnabled
    public static BankCard__c CreateBankCard(String cardRequest){
        CUser__c user = AuthController.CheckAuthUser();
        BankCard__c card = (BankCard__c)JSON.deserialize(cardRequest, BankCard__c.class);
        ValidateNewBankCard(user, card); 
        
        card.UserID__c = user.Id;
        
        try {
        	insert card;
    	}
    	catch (DmlException e) {
        	throw new AuraHandledException(e.getMessage());    
    	} 
        
        return card;
    }
    
    @AuraEnabled
    public static BankCard__c RemoveBankCard(String cardId){  
        AuthController.CheckAuthUser();
        
        try {
            BankCard__c card = [SELECT Id FROM BankCard__c WHERE Id =: cardId];
        	delete card;
            return card;
    	}
    	catch (DmlException e) {
        	throw new AuraHandledException(e.getMessage());    
    	} 
    }
    
    @AuraEnabled
    public static List<BankCard__c> GetBankCards(){
        CUser__c user = AuthController.CheckAuthUser();
        return [SELECT Id, 
                CardNumber__c,
                CardOwner__c,
                ExpiryDate__c,
                Balance__c 
                FROM BankCard__c WHERE UserID__c = :user.Id];            
    }
    
    @AuraEnabled
    public static BankCard__c Pay(String bankcardId, Decimal cost){
        AuthController.CheckAuthUser();   
        BankCard__c card = [SELECT Id, 
                                    CardNumber__c,
                                    CardOwner__c,
                                    ExpiryDate__c,
                                    Balance__c 
                                    FROM BankCard__c WHERE Id = :bankcardId];  
        
        if(card.Balance__c < cost){
            throw new AuraHandledException('Недостаточно средств'); 
        }
        
        card.Balance__c -= cost;
        update card;
        return card;
    }
        
    private static void ValidateNewBankCard(CUser__c user, BankCard__c card){ 

        List <BankCard__c> cards = [SELECT Id FROM BankCard__c WHERE UserID__c = :user.Id];
        
        if(cards.SIZE() > 2){
            throw new AuraHandledException('Добавлено максимальное кол-во карт.');
        }
        
        if(String.isBlank(card.CardNumber__c) || card.CardNumber__c.length() < 16){
            throw new AuraHandledException('Введите корректный номер карты');
        }
        
        if(String.isBlank(card.ExpiryDate__c) || card.ExpiryDate__c.length() < 7){
            throw new AuraHandledException('Введите срок');
        }
        
        if(String.isBlank(card.CardOwner__c)){
            throw new AuraHandledException('Введите владельца');
        }   
    }
}