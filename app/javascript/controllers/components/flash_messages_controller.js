import Swal from 'sweetalert2'
import _ from "lodash"
import BaseController from "../base_controller"

export default class extends BaseController {
  static values = {
    flashes: Array
  }

  connect() {
    this.showFlashMessages()
  }

  showFlashMessages() {
    this.flashesValue.forEach((flash) => {
      let [ flashType, flashMessage ] = flash
      const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000
      });

      Toast.fire({
        icon: this.getFlashClass(flashType),
        title: this.getFlashMessage(flashMessage)
      })
    })

    let swals = document.getElementsByClassName("swal2-container")

    for(let i = 0; i < swals.length; i++) {
      swals[i].classList.add("z-index-999999")
    }
  }

  getFlashMessage(message) {
    if (_.isArray(message)) {
      if (message.length > 1) {
        return message.join("<br>")
      } else {
        return message[0];
      }
    } else {
      return message;
    }
  }

  getFlashClass(flashType)  {
    let flashClass = 'question'
    switch(flashType) {
      case 'success':
        flashClass = 'success'
        break
      case 'error':
        flashClass = 'error'
        break
      case 'alert':
        flashClass = 'warning'
        break
      case 'notice':
        flashClass = 'info'
        break
    }

    return flashClass;
  }
}
