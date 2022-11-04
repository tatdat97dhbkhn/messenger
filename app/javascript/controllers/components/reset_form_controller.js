import BaseController from "../base_controller";

export default class extends BaseController {
  reset() {
    this.element.reset()

    if (this.element.id === 'send-message-form') {
      const attachmentsPreview = document.getElementById('attachment-previews')
      attachmentsPreview.innerHTML = ''
      attachmentsPreview.classList.add('hidden')
    }
  }
}
