HttpRequest req = new HttpRequest();
req.setEndpoint('callout:Bank/accounts/Thompson');
req.setMethod('GET');
Http http = new Http();
HttpResponse res = http.send(req);
System.debug(res.getBody());
