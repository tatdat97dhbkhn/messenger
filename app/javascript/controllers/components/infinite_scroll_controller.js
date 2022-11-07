import { useIntersection } from "stimulus-use";
import BaseController from "../base_controller";

export default class AutoClick extends BaseController {
  options = {
    threshold: 0
  };

  connect() {
    useIntersection(this, this.options);
  }

  appear(entry) {
    setTimeout(() => {
      this.element.click()
    }, 500)
  }

  disappear(entry) {
  }
}
