({
    doInit: function(component, event, helper) {
        component.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Number Of Contacts', fieldName: 'Number_of_Contacts__c', type: 'number'},
            {label: 'Type', fieldName: 'Type', type: 'text'},
            {label: 'Phone', fieldName: 'phone', type: 'phone'}
        ]);
        // Fetch the account list from the Apex controller
        helper.getAccountList(component);
    }
    
})