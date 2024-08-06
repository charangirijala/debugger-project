import { api, LightningElement } from "lwc";

export default class PtocChild extends LightningElement {
  @api message;
  @api cardHeading;
  @api number;
  get returnNumber() {
    return this.number + 20;
  }
}
