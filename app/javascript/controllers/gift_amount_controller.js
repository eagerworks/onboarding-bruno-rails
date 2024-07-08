import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="gift-amount"
export default class extends Controller {
  static targets = ['amount', 'increaseButton', 'decreaseButton']

  editButtons() {
    switch (this.amountTarget.value) {
      case '0':
        this.decreaseButtonTarget.disabled = true
        break
      case '5':
        this.increaseButtonTarget.disabled = true
        break
      default:
        this.decreaseButtonTarget.disabled = false
        this.increaseButtonTarget.disabled = false
    }
  }

  decrease() {
    if (this.amountTarget.value > 0) {
      this.amountTarget.value --
    }
    this.editButtons()
  }

  increase() {
    if (this.amountTarget.value < 5) {
      this.amountTarget.value ++
    }
    this.editButtons()
  }

}
