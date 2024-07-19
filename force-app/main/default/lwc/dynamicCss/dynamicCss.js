import { LightningElement } from "lwc";

export default class DynamicCss extends LightningElement {
  percentage = 100;
  text = "Your browser is currently not supported.";
  alertClass =
    "slds-notify slds-notify_alert slds-alert_error slds-var-m-around_medium";
  changeHandler(event) {
    if (event.target.value === "Compatible") {
      this.alertClass = "slds-notify slds-notify_alert";
      this.text = "Your browser is now supported.";
    } else {
      this.alertClass =
        "slds-notify slds-notify_alert slds-alert_error slds-var-m-around_medium";
      this.text = "Your browser is currently not supported.";
    }
  }

  get percent() {
    return `width:${this.percentage}%`;
  }

  changeWidth(event) {
    this.percentage = event.target.value;
  }
}
