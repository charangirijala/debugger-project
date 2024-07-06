global class AnimalLocator {
  public static String getAnimalNameById(Integer id) {
    Http http = new Http();
    HttpRequest req = new HttpRequest();
    String endPoint =
      'https://th-apex-http-callout.herokuapp.com/animals/' + id;
    req.setEndpoint(endPoint);
    req.setMethod('GET');
    Map<String, Object> animal = new Map<String, Object>();
    HttpResponse res = http.send(req);

    if (res.getStatusCode() == 200) {
      Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(
        res.getBody()
      );
      animal = (Map<String, Object>) results.get('animal');

      return (String) animal.get('name');
    }

    return null;
  }
}
