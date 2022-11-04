import BaseController from "../base_controller";

export default class extends BaseController {
  static targets = ['userItemLinkHidden', 'userItem']

  activeUser(event) {
    const currentTarget = event.currentTarget

    this.userItemTargets.forEach(userItemTarget => {
      userItemTarget.classList.remove('bg-gray-800')
      userItemTarget.classList.add('hover:bg-gray-800')
    })

    currentTarget.classList.add('bg-gray-800')
    currentTarget.classList.remove('hover:bg-gray-800')

    const userItemLinkHidden = document.getElementById(this.targetPrefix(event))
    userItemLinkHidden.click()
  }
}
