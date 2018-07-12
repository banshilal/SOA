public class AccountsController {
    @AuraEnabled
    public static List <Account> getAccounts() {
        return [SELECT Id, name, Number_of_Contacts__c , Type, Phone FROM Account ORDER BY createdDate DESC LIMIT 10];
    }
}