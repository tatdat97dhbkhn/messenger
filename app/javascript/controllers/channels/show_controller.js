import BaseController from "../base_controller";
import consumer from "../../channels/consumer";

export default class extends BaseController {
  static values = {
    channelId: Number,
    senderId: Number
  }

  static targets = [
    'reactionBox'
  ]

  get scrollController() {
    return this.findController("list-messages-of-channel", "components--scroll")
  }

  connect() {
    this.subscription = consumer.subscriptions.create({ channel: "ChannelChatChannel", channel_id: this.channelIdValue }, {
      connected: this._connected.bind(this),
      disconnected: this._disconnected.bind(this),
      received: this._received.bind(this),
    })
  }

  disconnect() {
    console.log("Disconnected to the channel " + this.channelIdValue + "!");
    consumer.subscriptions.remove(this.subscription)
  }

  _connected() {
    console.log("Connected to the channel " + this.channelIdValue + "!");
  }

  _disconnected() {
    console.log("Disconnected to the channel " + this.channelIdValue + "!");
  }

  _received(data) {
    const listMessagesTarget = document.getElementById('list-messages-of-channel')

    if (data.sender_id === this.senderIdValue) {
      listMessagesTarget.insertAdjacentHTML('beforeend', data.sender_message)
      this.scrollController.toBottom()
    } else {
      listMessagesTarget.insertAdjacentHTML('beforeend', data.recipient_message)
    }
  }

  hideAllReactionBoxes() {
    this.reactionBoxTargets.forEach(reactionBoxTarget => {
      reactionBoxTarget.classList.add('hidden')
    })
  }

  toggleReactionBox(event) {
    event.stopPropagation();

    const reactionBoxReflex = document.getElementById(`${this.targetPrefix(event, 'btn')}Box`)
    let isShowing = true

    if (reactionBoxReflex.classList.contains('hidden')) {
      isShowing = false
    }

    this.hideAllReactionBoxes()

    if (!isShowing) {
      reactionBoxReflex.classList.remove('hidden')

      setTimeout(() => {
        reactionBoxReflex.classList.add('hidden')
      }, 10000)
    }
  }
}
