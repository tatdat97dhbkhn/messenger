import BaseController from "../base_controller"

export default class extends BaseController {
  static values = {
    content: String
  }

  static targets = [ 'displayContent' ]

  connect() {
      this.displayContentTarget.innerHTML = this.urlify(this.contentValue)
  }

  urlify(text) {
    const urlRegex = /(https?:\/\/[^\s]+)/g;
    return text.replace(urlRegex, function(url) {
      return '<a href="' + url + '" target="_blank" class="underline">' + url + '</a>';
    })
  }
}
