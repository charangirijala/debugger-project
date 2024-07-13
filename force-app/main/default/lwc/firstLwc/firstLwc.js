import { LightningElement, track } from "lwc";

export default class FirstLwc extends LightningElement {
  fullName = "Zero to Hero";
  title = "Aura";
  //methods

  @track
  address = {
    city: "Melborne",
    postcode: 3000,
    country: "Australia"
  };
  changeHandler(event) {
    //logic
    console.log("Change Handler invoked");
    this.title = event.target.value;
  }

  trackHandler(event) {
    this.address.city = event.target.value;
  }
}
