import BaseController from "../base_controller";
import consumer from "../../channels/consumer";

export default class extends BaseController {
  static values = {
    channelId: Number,
    senderId: Number
  }

  get scrollController() {
    return this.findController("list-conversations", "components--scroll")
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
    const listConversationsTarget = document.getElementById('list-conversations')

    if(data.conversation) {
      listConversationsTarget.insertAdjacentHTML('beforeend', data.conversation)
    } else if (data.sender_id === this.senderIdValue) {
      listConversationsTarget.insertAdjacentHTML('beforeend', data.sender_message)
      this.scrollController.toBottom()
    } else {
      listConversationsTarget.insertAdjacentHTML('beforeend', data.recipient_message)
    }
  }
}
