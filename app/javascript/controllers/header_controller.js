import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="header"
export default class extends Controller {
  static targets = [ "arrow", "circle"]
  static classes = [ "rotate", "hide"]

  transform_add() {
    this.arrowTarget.classList.add(this.rotateClass)
  }

  transform_remove() {
    this.arrowTarget.classList.remove(this.rotateClass)
  }

  hide() {
    this.circleTarget.classList.add(this.hideClass)
  }
}

