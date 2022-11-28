import BaseController from "../base_controller";

export default class extends BaseController {
  static targets = [
    'inputText',
    'replyMessageBox',
    'parentIdInput',
    'gifUrlInput'
  ]

  get resetFormController() {
    return this.findController("send-message-form", "components--reset-form")
  }

  sendLikeButton() {
    this.resetFormController.reset()

    const messageTypeInput = document.getElementById('message_form_type');
    messageTypeInput.value = 'icon'
    this.element.requestSubmit()
  }

  sendGif(gifUrl) {
    this.resetFormController.reset()
    const gifUrlInput = document.getElementById('message_form_gif_url');
    gifUrlInput.value = gifUrl
    this.element.requestSubmit()
  }

  showReplyMessageBox(replyTo, replyContent, parentId) {
    const replyToEle = this.replyMessageBoxTarget.getElementsByClassName('reply-to')[0]
    const replyContentEle = this.replyMessageBoxTarget.getElementsByClassName('reply-content')[0]

    this.replyMessageBoxTarget.classList.remove('hidden')
    replyToEle.innerHTML = replyTo
    replyContentEle.innerHTML = replyContent
    this.parentIdInputTarget.value = parentId
  }

  hideReplyMessageBox(event) {
    const currentTarget = event.currentTarget || event.target
    this.replyMessageBoxTarget.classList.add('hidden')
    this.parentIdInputTarget.value = ''
  }
}
