@isTest
public class TestDataFactory {
    public static List<Account> createAccountsWithConacts(Integer numAccts, Integer numConAcct) {
        List<Account> accts = new List<Account>();
        
        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }
        insert accts;
        
        List<Contact> conts = new List<Contact>();
        for (Integer j=0;j<numAccts;j++) {
            Account acct = accts[j];
            // For each account just inserted, add contacts
            for (Integer k=0;k<numConAcct;k++) {
                conts.add(new Contact(FirstName='Fname',
                                      LastName='Contact' + k,
                                      AccountId=acct.Id));
            }
        }
        // Insert all contacts for all accounts.
        insert conts;
        return accts;
    }
    
    public static List<Account> createAccounts(Integer numAccts) {
        List<Account> accts = new List<Account>();
        
        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }
        insert accts;
        return accts;
    }
    public static List<Contact> createContacts(Integer numCons) {
        List<Contact> conts = new List<Contact>();
        for (Integer k=0;k<numCons;k++) {
            conts.add(new Contact(FirstName='Fname',
                                  LastName='Contact' + k
                                 ));
        }
        insert conts;
        return conts;
    }
}