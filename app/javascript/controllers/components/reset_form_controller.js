import BaseController from "../base_controller";

export default class extends BaseController {
  reset() {
    this.element.reset()

    if (this.element.id === 'send-message-form') {
      const attachmentsPreview = document.getElementById('attachment-previews')
      attachmentsPreview.innerHTML = ''
      attachmentsPreview.classList.add('hidden')

      const messageTypeInput = document.getElementById('message_form_type');
      messageTypeInput.value = 'plain_text_or_attachment'

      document.getElementById('hide-reply-message-box').click()
    }
  }
}
