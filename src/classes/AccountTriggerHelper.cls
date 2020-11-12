
public with sharing class AccountTriggerHelper {

    public static void sendDataToExactOnline(List<Account> records) {
        String query = 'SELECT Name, VATNumber__c , Description, BillingCity  FROM Account WHERE Phone = NULL';
        Id batchInstanceId = Database.executeBatch(new BatchSendAccountsToExactOnline(BatchSendAccountsToExactOnline.Batchmode.ACCOUNTS,query));
    }

}