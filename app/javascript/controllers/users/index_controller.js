import BaseController from "../base_controller";

export default class extends BaseController {
  static targets = ['formSearch', 'inputSearch']

  search() {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      this.formSearchTarget.requestSubmit()
    }, 500);
  }
}
