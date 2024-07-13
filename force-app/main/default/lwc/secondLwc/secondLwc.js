import { LightningElement } from "lwc";

export default class SecondLwc extends LightningElement {
  isVisible = false;
  handleClick() {
    if (this.isVisible) this.isVisible = false;
    else this.isVisible = true;
  }
  get displayName() {
    return !this.isVisible ? "Show Data" : "Hide Data";
  }
}
