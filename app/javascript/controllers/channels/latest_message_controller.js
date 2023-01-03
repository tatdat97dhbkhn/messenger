import _ from 'lodash'
import Rails from "@rails/ujs"
import BaseController from "../base_controller";
import consumer from "../../channels/consumer";

export default class extends BaseController {
  static values = {
    channelId: String,
    channelType: String,
    senderId: Number,
    receiverId: Number
  }

  connect() {
    this.subscription = consumer.subscriptions.create({
      channel: "LatestMessageChannel",
      channel_id: this.channelIdValue,
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
    const latestMessageBox = document.getElementById(`channel_${this.channelIdValue}_last_message`)
    const readOrUnreadBox = document.getElementsByClassName(`channel_${this.channelIdValue}_read_or_unread_latest_message`)[0]

    latestMessageBox.classList.remove('text-sm', 'font-bold', 'unread')
    latestMessageBox.classList.add('text-gray-600')
    readOrUnreadBox.innerHTML = ''
  }

  unreadMessage(data) {
    const latestMessageBox = document.getElementById(`channel_${this.channelIdValue}_last_message`)
    const readOrUnreadBox = document.getElementsByClassName(`channel_${this.channelIdValue}_read_or_unread_latest_message`)[0]

    latestMessageBox.classList.add('text-sm', 'font-bold', 'unread')
    latestMessageBox.classList.remove('text-gray-600')
    readOrUnreadBox.innerHTML = data.unread
  }

  updateLatestMessage(data) {
    const latestMessageBox = document.getElementById(`channel_${this.channelIdValue}_last_message`)
    const isTabActive = document.getElementById('is_tab_active')?.value

    latestMessageBox.innerHTML = data.latest_message

    const currentUserActiveChannel = _.includes(data.connected_user_ids, parseInt(this.senderIdValue))

    if (data.sender_id !== this.senderIdValue) {
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

      const audioTag = document.getElementById("notice-audio-tag");
      audioTag.play();
    } else {
      // if (_.includes(data.connected_user_ids, parseInt(this.receiverIdValue))) {
      //   readOrUnreadBox.innerHTML = data.read
      // } else {
      //   readOrUnreadBox.innerHTML = ''
      // }
    }
  }

  updateChannelName(data) {
    const channelNameTargets = document.getElementsByClassName(`channel-${data.channel_id}-name`)

    for (let i = 0; i < channelNameTargets.length; i++) {
      channelNameTargets[i].innerHTML = data.channel_name
    }
  }

  updateChannelPhoto(data) {
    const channelPhotoTargets = document.getElementsByClassName(`channel-${data.channel_id}-photo`)

    for (let i = 0; i < channelPhotoTargets.length; i++) {
      channelPhotoTargets[i].innerHTML = data.photo_partial
    }
  }

  _received(data) {
    if (data.type === 'update_latest_message') {
      this.updateLatestMessage(data)
    } else if (data.type === 'update_name') {
      this.updateChannelName(data)
    } else if (data.type === 'update_photo') {
      this.updateChannelPhoto(data)
    }
  }
}
