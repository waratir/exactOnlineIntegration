
public with sharing class BatchSendAccountsToExactOnline implements Database.Batchable<SObject>, Database.AllowsCallouts {
    public final String QUERY;
    public final String FIELD;
    public final Boolean VALUE;

    public BatchSendAccountsToExactOnline (String q, String f, Boolean v){
        this.QUERY = q;
        this.FIELD = f;
        this.VALUE = v;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(QUERY);
    }
    public void execute(Database.BatchableContext bc, List<SObject> records) {
        ConnectWithExactonline postRequest = new ConnectWithExactonline();
        postRequest.postSObjectToExactOnline(records[0]);
        for (SObject item: records){
            item.put(FIELD, VALUE);
        }
        update records;
    }
    public void finish(Database.BatchableContext bc) {

    }

}