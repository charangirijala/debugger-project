import { api, LightningElement } from "lwc";

export default class Numerator extends LightningElement {
  //@api counter;
  _currentCount = 0;
  priorCount = 0;

  @api
  get counter() {
    return this._currentCount;
  }
  set counter(value) {
    this.priorCount = this._currentCount;
    this._currentCount = value;
  }
  handleIncrement() {
    this.counter++;
    console.log("+ called");
  }

  handleDecrement() {
    this.counter--;
  }

  handleMultiply(event) {
    console.log("In multiply");
    const factor = event.detail;
    // eslint-disable-next-line @lwc/lwc/no-api-reassignments
    this.counter = this.counter * factor;
  }
  @api
  maximizeCounter() {
    // eslint-disable-next-line @lwc/lwc/no-api-reassignments
    this.counter += 1000000;
  }
}
