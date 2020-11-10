
public with sharing class BatchSendAccountsToExactOnline implements Database.Batchable<SObject>, Database.AllowsCallouts {
    public final String QUERY;
    public final String sObjectName;

    public BatchSendAccountsToExactOnline (String query, String sObjectName){
        this.QUERY = query;
        this.sObjectName = sObjectName;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(QUERY);
    }
    public void execute(Database.BatchableContext bc, List<SObject> records) {
        ConnectWithExactonline postRequest = new ConnectWithExactonline();
        for (SObject obj: records){
            switch on sObjectName {
                when 'Account' {
                    postRequest.postAccountToExactOnline((Account) obj);
                }
                when 'Case' {
                    postRequest.postOrderToExactOnline((Order) obj);
                }
                when 'Subscription' {
                    postRequest.postAccountToExactOnline((Account) obj);
                }
                when else {
                    System.debug('null point Exception');
                }
            }
        }
    }
    public void finish(Database.BatchableContext bc) {

    }

}