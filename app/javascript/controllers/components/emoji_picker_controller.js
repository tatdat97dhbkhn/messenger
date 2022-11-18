import { createPopup } from "@picmo/popup-picker";
import BaseController from "../base_controller";

export default class extends BaseController {
  static targets = [ 'rootElement', 'triggerElement' ]

  connect() {
    const currentController = this

    this.picker = createPopup(
      {
        rootElement: currentController.rootElementTarget
      },
      {
        triggerElement: currentController.triggerElementTarget,
        referenceElement: currentController.triggerElementTarget,
        position: "bottom-start",
      }
    );

    this.picker.addEventListener("emoji:select", (event) => {
      currentController.messagesCreateController.inputTextTarget.value = event.emoji
      currentController.messagesCreateController.element.requestSubmit()
    });
  }

  get messagesCreateController() {
    return this.findController("send-message-form", "messages--create")
  }

  toggle() {
    this.picker.toggle()
  }
}
