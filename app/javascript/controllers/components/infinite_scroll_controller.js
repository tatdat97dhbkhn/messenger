import BaseController from "../base_controller";

export default class AutoClick extends BaseController {
  static targets = ['box', 'loadingIcon']

  loadMore() {
    const btnLoadMore = document.getElementById('btn-load-more')

    if (!btnLoadMore) return false

    if (this.boxTarget.scrollTop <= 0) {
      this.loadingIconTarget.classList.remove('hidden')
      btnLoadMore.click()
    }
  }
}
