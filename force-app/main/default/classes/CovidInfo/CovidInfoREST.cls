public class CovidInfoREST {
  @AuraEnabled(cacheable=true)
  public static List<Object> covidRESTCall(String countryCode) {
    Http http = new Http();
    HttpRequest req = new HttpRequest();
    String endpoint =
      'https://covid-19-data.p.rapidapi.com/country/code?format=json&code=' +
      countryCode;
    req.setEndpoint(endpoint);
    req.setMethod('GET');
    req.setHeader(
      'x-rapidapi-key',
      '66aa3222edmsh6558d6094a9be7ep1ae397jsna1470871c682'
    );
    req.setHeader('x-rapidapi-host', 'covid-19-data.p.rapidapi.com');
    HttpResponse res = http.send(req);
    List<Object> result = (List<Object>) JSON.deserializeUntyped(res.getBody());
    return result;
  }
}
