import BaseController from "../base_controller";

export default class extends BaseController {
  static targets = [ 'formUpdateChannelName', 'btnOpenForm', 'btnCloseForm' ]

  openForm(event) {
    event.target.classList.add('hidden')
    const form = event.target.dataset.for

    this.btnCloseFormTargets.forEach(btnCloseFormTarget => {
      if (btnCloseFormTarget.dataset.for === form) {
        btnCloseFormTarget.classList.remove('hidden')
      }
    })

    this[`${form}Target`].classList.remove('hidden')
  }

  closeForm(event) {
    event.target.classList.add('hidden')

    const form = event.target.dataset.for

    this.btnOpenFormTargets.forEach(btnOpenFormTarget => {
      if (btnOpenFormTarget.dataset.for === form) {
        btnOpenFormTarget.classList.remove('hidden')
      }
    })

    this[`${form}Target`].classList.add('hidden')
  }
}
