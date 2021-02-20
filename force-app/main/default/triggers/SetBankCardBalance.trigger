trigger SetBankCardBalance on BankCard__c (before insert) {
    for (BankCard__c card : Trigger.new) {
        card.Balance__c = 100000;
    }
}