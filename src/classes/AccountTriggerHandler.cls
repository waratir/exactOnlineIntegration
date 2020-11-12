public with sharing class AccountTriggerHandler extends TriggerHandler {
    private Map<Id, Account> newOppMap;

    public AccountTriggerHandler() {
        this.newOppMap = (Map<Id, Account>) Trigger.newMap;
    }

    public override void afterInsert() {
        String query = 'SELECT Name, VATNumber__c , Description, BillingCity  FROM Account WHERE Phone = NULL';
        Id batchInstanceId = Database.executeBatch(new BatchSendAccountsToExactOnline(BatchSendAccountsToExactOnline.Batchmode.ACCOUNTS,query));
        System.debug('new framework');
    }
}