public with sharing class AuthController {
  @AuraEnabled
  public static CUser__c AuthUser(String userRequest) {
    CUser__c user = (CUser__c) JSON.deserialize(userRequest, CUser__c.class);

    ValidateAuth(user);

    CUser__c currentUser = [
      SELECT
        Login__c,
        Email__c,
        Password__c,
        TokenExpiryDate__c,
        TokenValue__c,
        Country__c,
        City__c,
        Street__c,
        ZIP__c,
        Phone__c
      FROM CUser__c
      WHERE Login__c = :user.Login__c
      LIMIT 1
    ];

    CreateToken(currentUser);

    return currentUser;
  }

  @AuraEnabled
  public static CUser__c LogoutUser(String userRequest) {
    CUser__c user = (CUser__c) JSON.deserialize(userRequest, CUser__c.class);

    ClearToken(user);

    return null;
  }

  @AuraEnabled
  public static CUser__c CheckAuthUser() {
    String token = GetToken();

    List<CUser__c> userByTokenList = [
      SELECT
        Login__c,
        Email__c,
        Password__c,
        TokenExpiryDate__c,
        TokenValue__c,
        Country__c,
        City__c,
        Street__c,
        ZIP__c,
        Phone__c
      FROM CUser__c
      WHERE TokenValue__c = :token
      LIMIT 1
    ];
    if (userByTokenList.size() == 0) {
      throw new AuthCheckException('Пожалуйста, авторизуйтесь.');
    }

    CUser__c userByToken = userByTokenList[0];

    if (Datetime.now() > userByToken.TokenExpiryDate__c) {
      ClearToken(userByToken);
      throw new AuthCheckException('Пожалуйста, авторизуйтесь.');
    }

    CreateToken(userByToken);
    return userByToken;
  }

  public static String CreateToken(CUser__c user) {
    user.TokenValue__c = GetToken();
    user.TokenExpiryDate__c = Datetime.now().addHours(1);
    update user;

    return user.TokenValue__c;
  }

  public static void ClearToken(CUser__c user) {
    user.TokenValue__c = null;

    try {
      update user;
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
  }

  public static String GetToken() {
    return Util.EncryptString(Util.GetUserIPAddress());
  }

  private static void ValidateAuth(CUser__c user) {
    List<CUser__c> userCandidateList = [
      SELECT Password__c
      FROM CUser__c
      WHERE Login__c = :user.Login__c
      LIMIT 1
    ];

    if (userCandidateList.size() == 0) {
      throw new AuraHandledException(
        'Пользователь с таким логином не зарегистрирован.'
      );
    }

    CUser__c userCandidate = userCandidateList[0];

    String pass = Util.EncryptString(user.Password__c);

    if (userCandidate.Password__c != pass) {
      throw new AuraHandledException('Неверный логин или пароль.');
    }
  }
}
