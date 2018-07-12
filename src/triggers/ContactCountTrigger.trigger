trigger ContactCountTrigger on Contact (after insert, after update, after delete, after undelete) {
    ContactCountTriggerHandler.handleTrigger(Trigger.new, Trigger.old, Trigger.oldMap, Trigger.operationType);
}