import { LightningElement, track } from "lwc";
import covidRESTCall from "@salesforce/apex/CovidInfoREST.covidRESTCall";

export default class CovidData extends LightningElement {
  @track isError = false;
  @track covidData;
  countryCode;
  onCountryCodeChange(event) {
    this.countryCode = event.target.value;
    console.log(event.target.value);
    this.isError = false;
  }
  getCovidDetails() {
    console.log("Button clicked.. countryCode", this.countryCode);
    covidRESTCall({ countryCode: this.countryCode })
      .then((data) => {
        console.log("Response From Server:", JSON.stringify(data));
        this.covidData = data;
        if (data.length === 0) {
          this.isError = true;
        }
      })
      .catch((err) => {
        console.log(err);
        this.isError = true;
      });
  }
}
