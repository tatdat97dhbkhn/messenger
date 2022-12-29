import { DirectUpload } from "@rails/activestorage";
import BaseController from "../base_controller";

export default class extends BaseController {
  static targets = ['audioRecordButton', 'formSubmit', 'inputUpload']

  connect() {
    this.audio()
  }

  audio() {
    let record = this.audioRecordButtonTarget
    let inputUpload = this.inputUploadTarget

    let recording = false
    const currentController = this

    if (navigator.mediaDevices.getUserMedia) {
      const constraints = { audio: true }
      let chunks = []

      let onSuccess = function (stream) {
        const mediaRecorder = new MediaRecorder(stream)

        record.onclick = function (event) {
          event.preventDefault()
          if (recording) {
            mediaRecorder.stop()
            record.style.color = ""
          } else {
            mediaRecorder.start()
            record.style.color = "red"
          }
          recording = !recording
        };

        mediaRecorder.onstop = function (event) {
          const audioType = "audio/ogg; codecs=opus"
          const blob = new Blob(chunks, { type: audioType })
          chunks = []

          let file = new File([blob], "audio-message.ogg", {
            type: audioType,
            lastModified: new Date().getTime(),
          });
          let container = new DataTransfer()
          container.items.add(file)
          currentController.uploadFile(file)

          Array.from(inputUpload.files).forEach(oldFile => {
            container.items.add(oldFile)
          });

          inputUpload.files = container.files
          inputUpload.dispatchEvent(new Event("change"))
        };

        mediaRecorder.ondataavailable = function (e) {
          chunks.push(e.data)
        };
      };
      let onError = function (err) {
        console.log("The following error occurred: " + err)
      };

      navigator.mediaDevices.getUserMedia(constraints).then(onSuccess, onError)
    } else {
      console.log("getUserMedia not supported on your browser!")
    }
  }

  uploadFile(file) {
    // Your form needs the file_field direct_upload: true, which
    // provides data-direct-upload-url
    const inputUpload = this.inputUploadTarget
    const url = inputUpload.dataset.directUploadUrl
    const upload = new DirectUpload(file, url)
    const currentController = this

    upload.create((error, blob) => {
      if (error) {
        // idk, do something
      } else {
        // Add an appropriately-named hidden input to the form with a
        //  value of blob.signed_id so that the blob ids will be
        //  transmitted in the normal upload flow

        // don't make the input hidden because we used DataTransfer to reset the input's files

        // const hiddenField = document.createElement("input")
        // hiddenField.setAttribute("type", "hidden")
        // hiddenField.setAttribute("value", blob.signed_id)
        // hiddenField.name = inputUpload.name
        // currentController.formSubmitTarget.appendChild(hiddenField)
      }
    });
  }
}
