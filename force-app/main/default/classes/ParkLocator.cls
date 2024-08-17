public class ParkLocator {
  public static List<String> country(String country) {
    parkService.ParksImplPort prkSvc = new parkService.ParksImplPort();
    return prkSvc.byCountry(country);
  }
}
