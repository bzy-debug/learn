class Page {
  constructor(text) {
    this.text = text
  }
  
  print() {
    console.log(this.text)
  }
}

class Notebook {
  constructor() {
    this.pages = []
  }
  
  addPage(text) {
    let page = new Page(text)
    this.pages.push(page)
  }
  
  print() {
    for (let page of this.pages) {
      page.print()
    }
  }
}

let mathNotes = new Notebook();
mathNotes.addPage("Arithmetic: + - * / ...");
mathNotes.addPage("Trigonometry: sin cos tan ...");

mathNotes.print();