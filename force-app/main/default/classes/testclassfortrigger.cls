public class testclassfortrigger {
  public static void exemethod() {
    if (Trigger.isExecuting) {
      System.debug('Exectuing in trigger context');
    }
    System.debug('Exectuing in normal context');
  }
}
