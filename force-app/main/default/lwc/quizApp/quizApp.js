import { LightningElement } from "lwc";

export default class QuizApp extends LightningElement {
  selected = new Map();
  score = 0;
  myQuestions = [
    {
      id: "Question1",
      question: "Which one of the following is not a template loop?",
      answers: {
        a: "for:each",
        b: "iterator",
        c: "map loop"
      },
      correctAnswer: "c"
    },
    {
      id: "Question2",
      question: "Which of the file is invald in LWC component folder?",
      answers: {
        a: ".svg",
        b: ".apex",
        c: ".js"
      },
      correctAnswer: "b"
    },
    {
      id: "Question3",
      question: "WHich one of the following is not a directive?",
      answers: {
        a: "for:each",
        b: "if:true",
        c: "@track"
      },
      correctAnswer: "c"
    }
  ];
  isDisabled = true;
  changeHandler(event) {
    console.log("Name", event.target.name);
    console.log("Value", event.target.value);
    const { name, value } = event.target;
    this.selected.set(name, value);

    if (this.selected.size === 3) {
      this.isDisabled = false;
      console.log("All three options selected", this.isDisabled);
    } else {
      this.isDisabled = true;
    }
  }

  onSubmit(event) {
    event.preventDefault();
    //loop through options
    console.log(this.selected);
    this.myQuestions.forEach((singleQues) => {
      if (this.selected.get(singleQues.id) === singleQues.correctAnswer) {
        console.log(this.selected.get(singleQues.id));
        console.log(singleQues.correctAnswer);
        this.score++;
      }
    });
  }

  resetHandler() {
    this.selected.clear();
    this.score = 0;
  }
}
