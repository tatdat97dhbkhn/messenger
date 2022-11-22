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
      const textInput = currentController.messagesCreateController.inputTextTarget
      const currentValue = textInput.value
      const start = textInput.selectionStart;
      const end = textInput.selectionEnd;
      const splitted = currentValue.split("");

      splitted.splice(start, end - start, event.emoji);
      textInput.value = splitted.join("")
    });
  }

  get messagesCreateController() {
    return this.findController("send-message-form", "messages--create")
  }

  toggle() {
    this.picker.toggle()
  }
}
