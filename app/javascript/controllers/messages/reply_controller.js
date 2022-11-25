import BaseController from "../base_controller";

export default class extends BaseController {
  get messagesCreateController() {
    return this.findController("send-message-form", "messages--create")
  }

  showReplyMessageBox(event) {
    const currentTarget = event.currentTarget || event.target

    this.messagesCreateController.showReplyMessageBox(
      `Replying to ${currentTarget.dataset.replyTo}`,
      currentTarget.dataset.replyContent,
      currentTarget.dataset.parentId,
    )
  }
}
