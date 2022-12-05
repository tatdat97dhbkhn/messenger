import BaseController from "../base_controller";
import consumer from "../../channels/consumer";

export default class extends BaseController {
  connect() {
    let resetFunc;
    let timer = 0;

    consumer.subscriptions.create("AppearanceChannel", {
      initialized() {
        console.log("AppearanceChannel Initialized");
      },
      connected() {
        // Called when the subscription is ready for use on the server
        console.log("AppearanceChannel Connected");
        resetFunc = () => this.resetTimer();
        this.install();
        window.addEventListener("turbo:load", () => {
          this.resetTimer()
        });
      },
      disconnected() {
        // Called when the subscription has been terminated by the server
        console.log("AppearanceChannel Disconnected");
        this.uninstall();
      },
      rejected() {
        console.log("AppearanceChannel Rejected");
        this.uninstall();
      },
      received(data) {
        // Called when there's incoming data on the websocket for this channel
      },
      online() {
        console.log("online");
        document.getElementById("current_user_status").value = 'online'
        this.perform("online");
      },
      away() {
        console.log("away");
        document.getElementById("current_user_status").value = 'away'
        this.perform("away");
      },
      offline() {
        console.log("offline");
        document.getElementById("current_user_status").value = 'offline'
        this.perform("offline");
      },
      uninstall() {
        const shouldRun = document.getElementById("appearance_channel");
        if (!shouldRun) {
          clearTimeout(timer);
          this.perform("offline");
        }
      },
      install() {
        console.log("Install");
        window.removeEventListener("load", resetFunc);
        window.removeEventListener("DOMContentLoaded", resetFunc);
        window.removeEventListener("click", resetFunc);
        window.removeEventListener("keydown", resetFunc);

        window.addEventListener("load", resetFunc);
        window.addEventListener("DOMContentLoaded", resetFunc);
        window.addEventListener("click", resetFunc);
        window.addEventListener("keydown", resetFunc);
        this.resetTimer();
      },
      resetTimer() {
        this.uninstall();
        const shouldRun = document.getElementById("appearance_channel");

        if (!!shouldRun) {
          const currentUserStatus = document.getElementById("current_user_status").value
          if (currentUserStatus !== 'online') this.online();
          clearTimeout(timer);

          const timeInSeconds = 300;
          const milliseconds = 1000;
          const timeInMilliseconds = timeInSeconds * milliseconds;

          timer = setTimeout(this.away.bind(this), timeInMilliseconds);
        }
      },
    });
  }
}
