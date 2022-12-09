import BaseController from "../base_controller";
import consumer from "../../channels/consumer";

export default class extends BaseController {
  static targets = ['channelItemLinkHidden', 'channelItem']

  static values = {
    senderId: Number
  }

  get modalController() {
    return this.findController("components-modal-controller", "components--modal")
  }

  connect() {
    this.subscription = consumer.subscriptions.create({
      channel: "ListChannelsChannel",
    }, {
      connected: this._connected.bind(this),
      disconnected: this._disconnected.bind(this),
      received: this._received.bind(this),
    })
  }

  disconnect() {
    consumer.subscriptions.remove(this.subscription)
  }

  _connected() {}

  _disconnected() {}

  _received(data) {
    this.modalController.hideModal()

    if(data.is_new_channel) {
      const channelsBox = document.getElementById('channels')
      channelsBox.insertAdjacentHTML('afterbegin', data.channel_partial)
    }

    if (data.sender_id == this.senderIdValue) {
      const channelItemTarget = document.getElementById(`channel-item-${data.channel_id}`);
      const channelItemHidden = document.getElementById(`channelItem${data.channel_id}`);

      this.activeChannelFunc(channelItemTarget)
      channelItemHidden.click()
    }
  }

  activeChannelFunc(currentTarget) {
    this.channelItemTargets.forEach(channelItemTarget => {
      channelItemTarget.classList.remove('bg-gray-800')
      channelItemTarget.classList.add('hover:bg-gray-800')
    })

    currentTarget.classList.add('bg-gray-800')
    currentTarget.classList.remove('hover:bg-gray-800')

    const latestMessageBox = currentTarget.querySelector(`.channel_last_message`)
    const readOrUnreadBox = currentTarget.querySelector(`.channel_read_or_unread_latest_message`)

    latestMessageBox.classList.remove('text-sm', 'font-bold', 'unread')
    latestMessageBox.classList.add('text-gray-600')
    readOrUnreadBox.innerHTML = ''
  }

  activeChannel(event) {
    const currentTarget = event.currentTarget
    this.activeChannelFunc(currentTarget)

    const channelItemLinkHidden = document.getElementById(this.targetPrefix(event))
    channelItemLinkHidden.click()
  }
}
