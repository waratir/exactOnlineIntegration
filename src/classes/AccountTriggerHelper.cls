
public with sharing class AccountTriggerHelper {

    public static void sendDataToExactOnline(List<Account> records) {
        String query = 'SELECT Name FROM Account WHERE WHERE ExactId__c = NULL';
        String sObjectName = 'Account';
        Id batchInstanceId = Database.executeBatch(new BatchSendAccountsToExactOnline(query, sObjectName));
    }

}