import { LightningElement } from "lwc";

export default class QuerySelector extends LightningElement {
  fetchDetailsHandler() {
    const elem = this.template.querySelector("h1");
    console.log(elem.innerText);
    elem.style.border = "1px solid blue";
  }
}
