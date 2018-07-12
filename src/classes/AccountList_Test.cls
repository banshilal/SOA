@isTest
public class AccountList_Test {
	 @isTest
    private static void checkContactCount(){
        Account[] accts = TestDataFactory.createAccounts(20);
        List<Account> returnAccounts = AccountsController.getAccounts();
        System.assertEquals(10, returnAccounts.size());
    }
}