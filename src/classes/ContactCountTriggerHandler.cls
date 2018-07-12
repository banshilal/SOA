public class ContactCountTriggerHandler {
    static Map<Id, List<Contact>> mapAcctIdContactList;
    static Map<Id, List<Contact>> mapAcctIdDelContactList;
    static Set<Id> acctIds; 
    static List<Account> listAcct;
    
    public static void handleTrigger(List<Contact> workingRecords, List<Contact> oldRecords,Map<Id, Contact> oldRecordsMap, System.TriggerOperation triggerEvent ) {
        mapAcctIdContactList = new Map<Id, List<Contact>>();
        mapAcctIdDelContactList = new Map<Id, List<Contact>>();
        AcctIds = new Set<Id>();    
        listAcct = new List<Account>();
        switch on triggerEvent {
            when AFTER_INSERT,AFTER_UNDELETE {
                updateCount(workingRecords,mapAcctIdContactList);
            }
            when AFTER_DELETE {
                updateCount(oldRecords,mapAcctIdDelContactList);
            }
            when AFTER_UPDATE {
                Boolean removeReference;
                for(Contact con : workingRecords) {
                    removeReference = false;
                    if(String.isNotBlank(con.AccountId) && con.AccountId != oldRecordsMap.get(con.Id).AccountId) {
                        if(!mapAcctIdContactList.containsKey(con.AccountId)){
                            mapAcctIdContactList.put(con.AccountId, new List<Contact>());
                        }
                        mapAcctIdContactList.get(con.AccountId).add(con);
                        acctIds.add(con.AccountId);
                        if(String.isNotBlank(oldRecordsMap.get(con.Id).AccountId)){
                            removeReference = true;
                        }
                        
                        
                    } else if(String.isBlank(con.AccountId) && String.isNotBlank(oldRecordsMap.get(con.Id).AccountId)) {
                        removeReference = true;
                    }
                    
                    if(removeReference) {
                        if(!mapAcctIdDelContactList.containsKey(oldRecordsMap.get(con.Id).AccountId)){
                            mapAcctIdDelContactList.put(oldRecordsMap.get(con.Id).AccountId, new List<Contact>());
                        }
                        mapAcctIdDelContactList.get(oldRecordsMap.get(con.Id).AccountId).add(con); 
                        acctIds.add(oldRecordsMap.get(con.Id).AccountId);   
                    }
                    
                } 
            }
            
        }
        
        if(acctIds.size() > 0) {
            listAcct = [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id IN : acctIds];
            for(Account acct : listAcct) {
                Integer noOfConts = 0;
                if(mapAcctIdContactList.containsKey(acct.Id)) {
                    noOfConts += mapAcctIdContactList.get(acct.Id).size();
                    
                }
                if(mapAcctIdDelContactList.containsKey(acct.Id)) {
                    noOfConts -= mapAcctIdDelContactList.get(acct.Id).size();
                }
                acct.Number_of_Contacts__c = acct.Number_of_Contacts__c == 0 ? noOfConts : (acct.Number_of_Contacts__c + noOfConts);
                    }
            
            update listAcct;    
        }
    }
    
    private static void updateCount(List<Contact> records, Map<Id, List<Contact>> accountContactsMap){
        for(Contact con : records) {
            if(String.isNotBlank(con.AccountId)) {
                if(!accountContactsMap.containsKey(Con.AccountId)) {
                    accountContactsMap.put(con.AccountId, new List<Contact>());
                }
                accountContactsMap.get(con.AccountId).add(con); 
                acctIds.add(con.AccountId);
                
            }   
        }
    }
    
}