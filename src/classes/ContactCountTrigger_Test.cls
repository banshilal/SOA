@isTest
public class ContactCountTrigger_Test {
    @isTest
    private static void checkContactCount(){
        Account[] accts = TestDataFactory.createAccounts(1);
        Contact[] conts = TestDataFactory.createContacts(1);
        
        Account acc = [Select Number_of_Contacts__c From Account Where Id = :accts[0].Id];
        System.assertEquals(0, acc.Number_of_Contacts__c);
        
        conts[0].AccountId = accts[0].Id;
        Update conts[0];
        
        Account acc1 = [Select Number_of_Contacts__c From Account Where Id = :accts[0].Id];
        System.assertEquals(1, acc1.Number_of_Contacts__c);
        
        Contact newCon = new Contact(FirstName='Test', LastName='User', AccountId=accts[0].Id);
        Insert newCon;
        
        Account acc2 = [Select Number_of_Contacts__c From Account Where Id = :accts[0].Id];
        System.assertEquals(2, acc2.Number_of_Contacts__c);
        
        Delete newCon;
        Account acc3 = [Select Number_of_Contacts__c From Account Where Id = :accts[0].Id];
        System.assertEquals(1, acc3.Number_of_Contacts__c);
        
        Undelete newCon;
        Account acc4 = [Select Number_of_Contacts__c From Account Where Id = :accts[0].Id];
        System.assertEquals(2, acc4.Number_of_Contacts__c);
        
        
        
        //Bulkify test
        Account[] bulkAccts = TestDataFactory.createAccountsWithConacts(1,10);
        Account acc5 = [Select Number_of_Contacts__c From Account Where Id = :bulkAccts[0].Id];
        System.assertEquals(10, acc5.Number_of_Contacts__c);
        
        
    }
}