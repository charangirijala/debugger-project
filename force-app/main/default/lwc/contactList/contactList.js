import { LightningElement, wire } from "lwc";
import getContacts from "@salesforce/apex/ContactController.getContacts";
import FIRST_NAME from "@salesforce/schema/Contact.FirstName";
import LAST_NAME from "@salesforce/schema/Contact.LastName";
import EMAIL from "@salesforce/schema/Contact.Email";
import { reduceErrors } from "c/ldsUtils";

const COLUMNS = [
  {
    label: "Contact FirstName",
    fieldName: FIRST_NAME.fieldApiName,
    type: "text"
  },
  {
    label: "Contact LastName",
    fieldName: LAST_NAME.fieldApiName,
    type: "text"
  },
  {
    label: "Contact Email",
    fieldName: EMAIL.fieldApiName,
    type: "email"
  }
];
export default class ContactList extends LightningElement {
  columns = COLUMNS;
  @wire(getContacts)
  ContactList;

  get errors() {
    return this.ContactList.error ? reduceErrors(this.ContactList.error) : [];
  }
}
