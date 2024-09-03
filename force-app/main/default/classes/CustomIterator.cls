public class CustomIterator implements Iterator<Integer> {
  private Integer[] nums;
  private Integer currIdx;

  public CustomIterator(Integer[] nums) {
    this.nums = nums;
    this.currIdx = 0;
  }

  public Boolean hasNext() {
    while (currIdx < nums.size()) {
      if (Math.mod(nums[currIdx], 2) == 0) {
        return true;
      }
      currIdx++;
    }

    return false;
  }

  public Integer next() {
    if (hasNext()) {
      return nums[currIdx++];
    }

    return null;
  }
}
