import BaseController from "../base_controller";

export default class extends BaseController {
  static targets = [
    'gifsModal'
  ]

  get messageCreateController() {
    return this.findController("send-message-form", "messages--create")
  }

  toggleGifsModal(event) {
    this.gifsModalTarget.classList.toggle('hidden')

    if (this.gifsModalTarget.classList.contains('hidden')) {
      event.preventDefault()
      return false
    }
  }

  search(event) {
    document.getElementById('inputSearchGifs').value = event.target.value
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      document.getElementById('formSearchGifs').requestSubmit()
    }, 500);
  }

  selectGif(event) {
    this.messageCreateController.sendGif(event.target.dataset.url)
    this.gifsModalTarget.classList.add('hidden')
  }
}
