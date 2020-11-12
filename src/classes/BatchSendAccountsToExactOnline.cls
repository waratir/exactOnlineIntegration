
public with sharing class BatchSendAccountsToExactOnline implements Database.Batchable<SObject>, Database.AllowsCallouts {
    public final String BATCH_MODE_EXC = 'UNSUPPORTED mode. BatchSendAccountsToExactOnline have problems with mode param';
    public enum Batchmode {ACCOUNTS, CASES, SUBSCRIPTION}
    public final String QUERY;

    Batchmode mode;

    public BatchSendAccountsToExactOnline (Batchmode mode, String query){
        this.mode = mode;
        this.QUERY = query;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(QUERY);
    }
    public void execute(Database.BatchableContext bc, List<SObject> records) {
        ConnectWithExactonline postRequest = new ConnectWithExactonline();
        for (SObject obj: records){
            switch on this.mode {
                when ACCOUNTS {
                    StaticResource jsonSR = [SELECT Body FROM StaticResource WHERE Name = 'AccountMapping' LIMIT 1];
                    String body = jsonSR.Body.toString();
                    Map<String, Object> objectMap = (Map<String, Object>) JSON.deserializeUntyped(body);
                    postRequest.postAccountToExactOnline((Account) obj, objectMap, 'Account');
                }
                when CASES {
                    StaticResource jsonSR = [SELECT Body FROM StaticResource WHERE Name = 'CaseMapping' LIMIT 1];
                    String body = jsonSR.Body.toString();
                    Map<String, Object> objectMap = (Map<String, Object>) JSON.deserializeUntyped(body);
                    postRequest.postAccountToExactOnline((Account) obj, objectMap, 'Case');
                }
                when SUBSCRIPTION {
                    StaticResource jsonSR = [SELECT Body FROM StaticResource WHERE Name = 'SubscriptionMapping' LIMIT 1];
                    String body = jsonSR.Body.toString();
                    Map<String, Object> objectMap = (Map<String, Object>) JSON.deserializeUntyped(body);
                    postRequest.postAccountToExactOnline((Account) obj, objectMap, 'Subscription');                }
                when else {
                    throw new BatchSendAccountsToExactOnlineException(BATCH_MODE_EXC);
                }
            }
        }
    }
    public void finish(Database.BatchableContext bc) {

    }

}