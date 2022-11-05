import BaseController from "../base_controller";

export default class extends BaseController {
  static targets = ['audio', 'btnPlay', 'btnStop']
  connect() {
    this.currentlyPlaying = false
  }

  playAndStop() {
    this.btnPlayTarget.classList.toggle('hidden')
    this.btnStopTarget.classList.toggle('hidden')

    if (this.currentlyPlaying) {
      this.audioTarget.pause();
      this.audioTarget.currentTime = 0;
      this.currentlyPlaying = false;
    } else {
      this.audioTarget.play();
      this.currentlyPlaying = true;
    }
  }
}
