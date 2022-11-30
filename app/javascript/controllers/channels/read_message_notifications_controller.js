import Rails from "@rails/ujs"
import BaseController from "../base_controller";

export default class extends BaseController {
  static values = {
    channelNameOrId: String,
    channelId: Number
  }

  readMessageNotifications() {
    const latestMessageBox = document.getElementById(`channel_${this.channelNameOrIdValue}_user_last_message`)
    const currentController = this

    if (latestMessageBox.classList.contains('unread')) {
      const readOrUnreadBox = document.getElementsByClassName(`channel_${this.channelNameOrIdValue}_read_or_unread_latest_message`)[0]

      latestMessageBox.classList.remove('text-sm', 'font-bold', 'unread')
      latestMessageBox.classList.add('text-gray-600')
      readOrUnreadBox.innerHTML = ''

      Rails.ajax({
        url: `/chat/channels/${currentController.channelIdValue}/read_message_notifications`,
        type: "PUT",
        success: function(notice) {
        },
        error: function (errors) {
        }
      })
    }
  }
}
