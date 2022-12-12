import BaseController from "../base_controller";

export default class extends BaseController {
  static targets = ['tab']

  hideModal() {
    this.element.innerHTML = ''
    this.element.classList.add('hidden')
  }

  next(event) {
    this.hideModal()

    const respone = event.detail.fetchResponse

    if (respone.succeeded) {
      // debugger
    }
  }

  activeTab(event) {
    this.tabTargets.forEach(tabTarget => {
      tabTarget.classList.remove('bg-gray-600')
    })

    event.currentTarget.classList.add('bg-gray-600')
  }
}
