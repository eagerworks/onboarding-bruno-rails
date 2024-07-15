import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gift-price"
export default class extends Controller {
  static targets = ['giftPrice']

  modifyPrice(event) {
    const customPrice = event.params.customprice
    if (event.target.checked) {
      this.giftPriceTarget.value = Number(this.giftPriceTarget.value) + Math.round(customPrice)
    } else {
      this.giftPriceTarget.value = Number(this.giftPriceTarget.value) - Math.round(customPrice)
    }
  }

}
