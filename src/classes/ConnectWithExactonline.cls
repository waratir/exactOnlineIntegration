public with sharing class ConnectWithExactonline {

    public void getExactonline() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Exactonline_Test/api/v1/2844363/crm/Accounts');
        request.setHeader('Accept', 'application/json');
        request.setMethod('GET');
        Http http = new Http();
        HttpResponse res = http.send(request);
        System.debug(res.getBody());
        String jsonST = JSON.serialize([SELECT Body FROM StaticResource WHERE Name = 'AccountMapping' LIMIT 1]);
    }

    public void postAccountToExactOnline(SObject record, Map<String, Object> jsonMapping, String sObjectName) {
        Map<String, Object> requestMap = new Map<String, Object>();
        Map<String, Object> recordsMap = new Map<String, Object>(record.getPopulatedFieldsAsMap());
        for (String key : jsonMapping.keySet()) {
            requestMap.put(key, recordsMap.get((String) jsonMapping.get(key)));
        }

        HttpRequest request = new HttpRequest();
        switch on sObjectName {
            when 'Account' {
                request.setEndpoint('callout:Exactonline_Test/api/v1/2844363/crm/Accounts');
            }
            when 'Case' {
                request.setEndpoint('callout:Exactonline_Test/api/v1/2844363/crm/Accounts');
            }
            when 'Subscription' {
                request.setEndpoint('callout:Exactonline_Test/api/v1/2844363/crm/Accounts');
            }
        }
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        request.setBody(JSON.serialize(requestMap));
        request.setMethod('POST');

        Http http = new Http();
        HttpResponse response = http.send(request);

        if (response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> responseParams = (Map<String, Object>) responseMap.get('d');
            String exactAccountId = (String) responseParams.get('ID');
            record.put('ExactId__c', exactAccountId);
            update record;
        }
    }

}