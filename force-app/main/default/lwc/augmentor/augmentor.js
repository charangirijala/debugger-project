import { LightningElement } from "lwc";

export default class Augmentor extends LightningElement {
  startCounter = 0;
  handleStartChange(event) {
    // eslint-disable-next-line radix
    this.startCounter = parseInt(event.target.value);
  }
  handleMaximizeCounter() {
    this.template.querySelector("c-numerator").maximizeCounter();
  }
}
