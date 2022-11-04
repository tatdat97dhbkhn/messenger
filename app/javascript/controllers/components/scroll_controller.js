import BaseController from "../base_controller";

export default class extends BaseController {
  connect() {
    // this.element.addEventListener("DOMNodeInserted", this.toBottom)

    this.toBottom()
  }

  toBottom() {
    this.element.scrollTop = this.element.scrollHeight
  }
}
