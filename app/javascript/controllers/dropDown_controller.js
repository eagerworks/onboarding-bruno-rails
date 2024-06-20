import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropDown"
export default class extends Controller {
  static targets = [ "arrow"]
  static classes = [ "rotate"]

  transformAdd() {
    this.arrowTarget.classList.add(this.rotateClass)
  }

  transformRemove() {
    this.arrowTarget.classList.remove(this.rotateClass)
  }
}

