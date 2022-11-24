import BaseController from "../base_controller";

export default class extends BaseController {
  static targets = [
    'formSubmit',
    'typeInputHidden'
  ]

  react(event) {
    this.typeInputHiddenTarget.value = event.target.dataset.type
    this.formSubmitTarget.requestSubmit()
  }
}
