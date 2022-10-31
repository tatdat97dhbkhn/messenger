import { Controller } from "@hotwired/stimulus"
import _ from "lodash";

export default class BaseController extends Controller {
  findController(id, controllerPath) {
    return this.application.getControllerForElementAndIdentifier(document.getElementById(id), controllerPath)
  }
}
