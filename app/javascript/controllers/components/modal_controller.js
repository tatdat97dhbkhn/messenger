import BaseController from "../base_controller";

export default class extends BaseController {
  hideModal() {
    this.element.innerHTML = ''
    this.element.classList.add('hidden')
  }
}
