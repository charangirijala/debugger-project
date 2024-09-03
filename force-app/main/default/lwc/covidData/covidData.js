import { LightningElement } from "lwc";
import covidRESTCall from "@salesforce/apex/CovidInfoREST.covidRESTCall";

export default class CovidData extends LightningElement {
  countryCode;
  onCountryCodeChange(event) {
    this.countryCode = event.target.value;
    console.log(event.target.value);
  }
  getCovidDetails() {
    console.log("Button clicked.. countryCode", this.countryCode);
    covidRESTCall(this.countryCode)
      .then((data, error) => {
        if (data) {
          console.log("Response From Server:", JSON.stringify(data));
        } else if (error) {
          console.log("Error: ", error);
        }
      })
      .catch((err) => {
        console.log(err);
      });
  }
}
