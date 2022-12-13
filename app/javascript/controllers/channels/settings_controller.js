import Rails from "@rails/ujs"
import BaseController from "../base_controller";

export default class extends BaseController {
  static targets = [ 'formUpdateChannelName' ]

  get flashMessagesController() {
    return this.findController("flash-messages", "components--flash-messages")
  }

  toggleForm(event) {
    const chevronDownIcon = event.currentTarget.querySelector('.chevron-down-icon')
    const chevronUpIcon = event.currentTarget.querySelector('.chevron-up-icon')
    const form = event.currentTarget.dataset.for

    if (chevronDownIcon.classList.contains('hidden')) {
      chevronDownIcon.classList.remove('hidden')
      chevronUpIcon.classList.add('hidden')
    } else {
      chevronDownIcon.classList.add('hidden')
      chevronUpIcon.classList.remove('hidden')
    }

    this[`${form}Target`].classList.toggle('hidden')
  }

  changePhoto(event) {
    const currentController = this
    const channelId = event.target.dataset.channelId
    let formData = new FormData()
    formData.append('channel_form[photo]', event.target.files[0])
    formData.append('channel_form[skip_validate_name]', true)
    formData.append('type', 'update_photo')

    Rails.ajax({
      url: `/chat/channels/${channelId}`,
      type: "PATCH",
      data: formData,
      contentType: false,
      processData: false,
      dataType: 'json',
      success: function(data) {
        if (data.errors) {
          currentController.flashMessagesController.flashesValue = [['error', data.errors]]
          currentController.flashMessagesController.showFlashMessages()
        } else {
          document.getElementById('components-modal').innerHTML = ''
        }
      },
      error: function (errors) {
      }
    })
  }
}
