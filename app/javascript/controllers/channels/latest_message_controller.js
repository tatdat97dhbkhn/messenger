import _ from 'lodash'
import Rails from "@rails/ujs"
import BaseController from "../base_controller";
import consumer from "../../channels/consumer";

export default class extends BaseController {
  static values = {
    channelNameOrId: String,
    channelType: String,
    senderId: Number,
    receiverId: Number
  }

  connect() {
    this.subscription = consumer.subscriptions.create({
      channel: "LatestMessageChannel",
      channel_name_or_id: this.channelNameOrIdValue,
      channel_type: this.channelTypeValue
    }, {
      connected: this._connected.bind(this),
      disconnected: this._disconnected.bind(this),
      received: this._received.bind(this),
    })
  }

  disconnect() {
    consumer.subscriptions.remove(this.subscription)
    document.removeEventListener("visibilitychange", this.handleDocumentVisibilityOrOnBlurFunc)
  }

  _connected() {
    document.addEventListener("visibilitychange", this.handleDocumentVisibilityOrOnBlurFunc)
  }

  handleDocumentVisibilityOrOnBlurFunc() {
    const isTabActiveInput = document.getElementById('is_tab_active')

    if (document.hidden) {
      isTabActiveInput.value = false
    } else {
      isTabActiveInput.value = true
    }
  }

  _disconnected() {}

  readMessage() {
    const latestMessageBox = document.getElementById(`channel_${this.channelNameOrIdValue}_user_last_message`)
    const readOrUnreadBox = document.getElementsByClassName(`channel_${this.channelNameOrIdValue}_read_or_unread_latest_message`)[0]

    latestMessageBox.classList.remove('text-sm', 'font-bold', 'unread')
    latestMessageBox.classList.add('text-gray-600')
    readOrUnreadBox.innerHTML = ''
  }

  unreadMessage(data) {
    const latestMessageBox = document.getElementById(`channel_${this.channelNameOrIdValue}_user_last_message`)
    const readOrUnreadBox = document.getElementsByClassName(`channel_${this.channelNameOrIdValue}_read_or_unread_latest_message`)[0]

    latestMessageBox.classList.add('text-sm', 'font-bold', 'unread')
    latestMessageBox.classList.remove('text-gray-600')
    readOrUnreadBox.innerHTML = data.unread
  }

  _received(data) {
    const latestMessageBox = document.getElementById(`channel_${this.channelNameOrIdValue}_user_last_message`)
    const isTabActive = document.getElementById('is_tab_active')?.value

    latestMessageBox.innerHTML = data.latest_message

    const currentUserActiveChannel = _.includes(data.connected_user_ids, parseInt(this.senderIdValue))

    if (data.sender_id !== this.senderIdValue) {
      const audioTag = document.getElementById("notice-audio-tag");
      audioTag.play();

      if (!currentUserActiveChannel) {
        this.unreadMessage(data)
      } else {
        if (isTabActive === 'false') {
          this.unreadMessage(data)

          let formData = new FormData()
          formData.append('user_id', this.senderIdValue)

          Rails.ajax({
            url: `/chat/channels/${data.channel_id}/messages/${data.message_id}/message_notifications`,
            type: "POST",
            data: formData,
            success: function(notice) {
            },
            error: function (errors) {
            }
          })
        } else {
          this.readMessage()
        }
      }
    } else {
      // if (_.includes(data.connected_user_ids, parseInt(this.receiverIdValue))) {
      //   readOrUnreadBox.innerHTML = data.read
      // } else {
      //   readOrUnreadBox.innerHTML = ''
      // }
    }
  }
}
