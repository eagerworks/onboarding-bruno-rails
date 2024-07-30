import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-destinations"
export default class extends Controller {
  static classes = ['hide']
  static targets = ['destinationCount', 'rightButton', 'leftButton', 'destinations', 'index']

  connect() {
    if (this.destinationCountTarget.innerHTML == 1) {
      this.rightButtonTarget.disabled = true
    }
  }

  left() {
    let actualIndex = parseInt(this.indexTarget.innerHTML)
    this.destinationsTarget.children[actualIndex].classList.add(this.hideClass)
    this.destinationsTarget.children[actualIndex - 1].classList.remove(this.hideClass)
    actualIndex--
    if (actualIndex == 0) {
      this.leftButtonTarget.disabled = true
    }
    this.indexTarget.innerHTML = actualIndex

    this.rightButtonTarget.disabled = false
  }

  right() {
    let actualIndex = parseInt(this.indexTarget.innerHTML)
    this.destinationsTarget.children[actualIndex].classList.add(this.hideClass)
    this.destinationsTarget.children[actualIndex + 1].classList.remove(this.hideClass)
    actualIndex++
    if (actualIndex + 1 == parseInt(this.destinationCountTarget.innerHTML)) {
      this.rightButtonTarget.disabled = true
    }
    this.indexTarget.innerHTML = actualIndex

    this.leftButtonTarget.disabled = false
  }
}
