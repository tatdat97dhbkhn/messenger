import _ from 'lodash'
import BaseController from "../base_controller";

export default class extends BaseController {
  static values = {
    avatarName: String,
    avatarPreview: String
  }

  static targets = [ 'imgPreview', 'fileUpload' ]

  allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i

  initialize() {
    this.avatarNameValue = null
    this.setUrlPreview()
  }

  get flashMessagesController() {
    return this.findController("flash-messages", "components--flash-messages")
  }

  setUrlPreview() {
    if (_.isEmpty(this.avatarPreviewValue)) {
      this.avatarPreviewValue = 'https://thumbs.dreamstime.com/b/no-user-profile-picture-24185395.jpg'
    }

    this.imgPreviewTarget.src = this.avatarPreviewValue
  }

  preview(event) {
    const currentController = this
    const file = event.target.files[0]

    if (!this.allowedExtensions.exec(event.target.value)) {
      this.flashMessagesController.flashesValue = [['error', ['File has an invalid content type']]]
      this.flashMessagesController.showFlashMessages()

      event.target.value = ''
      return false
    }

    this.avatarNameValue = file.name
    const reader = new FileReader()

    reader.onload = (e) => {
      currentController.avatarPreviewValue = e.target.result
      currentController.setUrlPreview()
    };
    reader.readAsDataURL(file)
  }

  selectFile() {
    this.fileUploadTarget.click()
  }
}
