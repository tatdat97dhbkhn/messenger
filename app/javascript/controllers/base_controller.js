import { Controller } from "@hotwired/stimulus"

export default class BaseController extends Controller {
  findController(id, controllerPath) {
    return this.application.getControllerForElementAndIdentifier(document.getElementById(id), controllerPath)
  }
}
