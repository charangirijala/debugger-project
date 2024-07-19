import { LightningElement } from "lwc";
import signIn from "./signIn.html";
import signUp from "./signUp.html";
import renderTemplate from "./renderMethod.html";
export default class RenderMethod extends LightningElement {
  selectedButton = "";
  render() {
    return this.selectedButton === "SignUp"
      ? signUp
      : this.selectedButton === "SignIn"
        ? signIn
        : renderTemplate;
  }

  handleClick(event) {
    this.selectedButton = event.target.label;
    console.log(this.selectedButton);
  }
}
