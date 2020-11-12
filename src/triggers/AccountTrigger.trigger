trigger AccountTrigger on Account (after insert) {
//    if(Trigger.isAfter && Trigger.isInsert){
//        AccountTriggerHelper.sendDataToExactOnline(Trigger.new);
//    }
    new AccountTriggerHandler().run();
}