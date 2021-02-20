public with sharing class CUserController {
    
    @AuraEnabled
    public static CUser__c CreateNewUser(String userRequest, String repeatPass){
        CUser__c newUser = (CUser__c)JSON.deserialize(userRequest, CUser__c.class);
        
        ValidateNewUser(newUser, repeatPass);
       
        newUser.Password__c = Util.EncryptString(newUser.Password__c);
        
        try {
        	insert newUser;
    	}
    	catch (Exception e) {
        	throw new AuraHandledException(e.getMessage());    
    	}

        return newUser;
    }
    
    @AuraEnabled
    public static CUser__c UpdateUser(String userRequest){
        CUser__c authUser = AuthController.CheckAuthUser();
        
        CUser__c user = (CUser__c)JSON.deserialize(userRequest, CUser__c.class);
        ValidateUpdateUser(user,authUser);
        try {
        	update user;
    	}
    	catch (Exception e) {
        	throw new AuraHandledException(e.getMessage());    
    	}

        return user;
    }
    
    @AuraEnabled
    public static void ResetPassword(String oldPassword, String newPassword, String passwordRepeat){
        CUser__c user = AuthController.CheckAuthUser();
        
        user.Password__c = newPassword;
        ValidateResetPassword(user, passwordRepeat);
        
        user.Password__c = Util.EncryptString(user.Password__c);
        
        update user;
    }
    
    private static void ValidateNewUser(CUser__c user, String repeatPass){
        
        if(user.Password__c != repeatPass){
            throw new AuraHandledException('Пароли не совпадают');
        }
        
        if( user.Password__c.length() < 8){
            throw new AuraHandledException('Пароль должен быть >= 8 символов');
        }
        
        List<CUser__c> sameUser = [SELECT Email__c FROM CUser__c WHERE Email__c = :user.Email__c LIMIT 1];
        
        if(sameUser.size()>0){
            throw new AuraHandledException('Пользователь с таким email уже зарегистрирован');
        }
        
        sameUser = [SELECT Email__c FROM CUser__c WHERE Login__c = :user.Login__c LIMIT 1];
        
        if(sameUser.size()>0){
            throw new AuraHandledException('Пользователь с таким логином уже зарегистрирован');
        }
    }
    
    private static void ValidateUpdateUser(CUser__c user, CUser__c authUser){
        
        if(user.Login__c.length()==0){
            throw new AuraHandledException('Укажите логин');
        }
        
        if(user.Email__c.length()==0){
            throw new AuraHandledException('Укажите email');
        }

        List<CUser__c> sameUser = [SELECT Email__c FROM CUser__c WHERE Email__c = :user.Email__c LIMIT 1];
        
        if(sameUser.size()>0 && authUser.Email__c != sameUser[0].Email__c){
            throw new AuraHandledException('Пользователь с таким email уже зарегистрирован');
        }
        
        sameUser = [SELECT Login__c FROM CUser__c WHERE Login__c = :user.Login__c LIMIT 1];
        
        if(sameUser.size()>0 && authUser.Login__c != sameUser[0].Login__c){
            throw new AuraHandledException('Пользователь с таким логином уже зарегистрирован');
        }
       
    }
    private static void ValidateResetPassword(CUser__c user, String repeatPass){
        
        if(user.Password__c != repeatPass){
            throw new AuraHandledException('Пароли не совпадают');
        }
        
        if( user.Password__c.length() < 8){
            throw new AuraHandledException('Пароль должен быть >= 8 символов');
        }
    }
}