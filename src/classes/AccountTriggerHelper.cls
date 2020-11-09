
public with sharing class AccountTriggerHelper {

    public static void sendDataToExactOnline(List<Account> records) {
        String query = 'SELECT Name FROM Account WHERE Sent__c = false LIMIT 1';
        String field = 'Sent__c';
        Boolean value = true;
        Id batchInstanceId = Database.executeBatch(new BatchSendAccountsToExactOnline(query, field, value));
    }

}