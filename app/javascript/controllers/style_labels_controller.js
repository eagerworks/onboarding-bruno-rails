import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="style-labels"
export default class extends Controller {
  static targets = ['checkBox', 'label']
  static classes = ['background', 'text']

  connect(){
    if (this.checkBoxTarget.checked) {
      this.labelTarget.classList.add(this.backgroundClass)
      this.labelTarget.classList.add(this.textClass)
    }
  }

  check() {
    if (this.checkBoxTarget.checked) {
      this.labelTarget.classList.add(this.backgroundClass)
      this.labelTarget.classList.add(this.textClass)
    }
  }
}
