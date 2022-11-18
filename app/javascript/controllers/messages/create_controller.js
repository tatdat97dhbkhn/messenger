import BaseController from "../base_controller";

export default class extends BaseController {
  static targets = [
    'inputText'
  ]

  sendLikeButton() {
    const messageTypeInput = document.getElementById('message_form_type');

    messageTypeInput.value = 'icon'

    this.element.requestSubmit()
  }
}
