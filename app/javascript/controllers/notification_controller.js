import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification"
export default class extends Controller {
  static targets = [ "circle"]
  static classes = [ "hide"]

  hide() {
    this.circleTarget.classList.add(this.hideClass)
  }
}
