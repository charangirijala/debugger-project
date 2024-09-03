public class CustomIterable implements Iterable<Integer> {
  private Integer[] nums;
  public CustomIterable(Integer[] numbers) {
    this.nums = numbers;
  }

  public Iterator<Integer> iterator() {
    return new CustomIterator(nums);
  }
}
