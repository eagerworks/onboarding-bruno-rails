import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="destinations"
export default class extends Controller {
  static targets = ['template', 'form', 'errorRemove']
  static classes = ['paddingWeb', 'paddingMobile', 'hide']


  add() {
    const newDestination = this.templateTarget.content.cloneNode(true)
    const inputs = newDestination.querySelectorAll('input')
    const id = this.formTarget.childElementCount
    for (let i = 0; i < inputs.length; i++) {
      inputs[i].setAttribute('name', inputs[i].getAttribute('name').replace('[template]', `[destinations_attributes][${id}]`))
      inputs[i].setAttribute('id', inputs[i].getAttribute('id').replace('[template]', `destinations_attributes_${id}`))
      inputs[i].value = ''
    }
    newDestination.querySelector('div').classList.add(this.paddingWebClass, this.paddingMobileClass)
    this.formTarget.appendChild(newDestination)
    this.errorRemoveTarget.classList.add(this.hideClass)
  }

  remove() {
    if (this.formTarget.childElementCount > 1) {
      this.formTarget.removeChild(this.formTarget.lastElementChild)
      this.errorRemoveTarget.classList.add(this.hideClass)
    } else {
      this.errorRemoveTarget.classList.remove(this.hideClass)
    }
  }
}

