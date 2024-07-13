import { LightningElement } from "lwc";

export default class Looping extends LightningElement {
  carList = ["Ford", "Audi", "BMW", "Porsche"];

  ceoList = [
    {
      id: 1,
      company: "Google",
      ceoName: "Sundar Pichai"
    },
    {
      id: 2,
      company: "Apple",
      ceoName: "Tim Cook"
    },
    {
      id: 3,
      company: "Microsoft",
      ceoName: "Satya Nadella"
    }
  ];
}
