import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="purchase-process"
export default class extends Controller {
  static targets = ["delivery", "purchase"]
  static classes = ['hide']

  showPurchase() {
    this.deliveryTarget.classList.add(this.hideClass)
    this.purchaseTarget.classList.remove(this.hideClass)
  }

  showDelivery() {
    this.deliveryTarget.classList.remove(this.hideClass)
    this.purchaseTarget.classList.add(this.hideClass)
  }
}
