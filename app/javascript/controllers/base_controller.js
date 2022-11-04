import { Controller } from "@hotwired/stimulus"
import _ from "lodash";

export default class BaseController extends Controller {
  findController(id, controllerPath) {
    return this.application.getControllerForElementAndIdentifier(document.getElementById(id), controllerPath)
  }

  targetPrefix(event, idSuffix = '') {
    const originalId = event.currentTarget?.id || event.target.id
    let idRoot = _.camelCase(originalId)

    if (idSuffix) {
      idRoot = idRoot.substring(0, idRoot.indexOf(_.upperFirst(_.camelCase(idSuffix))))
    }

    return idRoot
  }

  linkHiddenTarget(event, idSuffix = '') {
    return `${this.targetPrefix(event, idSuffix)}LinkHiddenTarget`
  }

  setAttributes(el, attrs) {
    for(const key in attrs) {
      el.setAttribute(key, attrs[key]);
    }
  }
}
