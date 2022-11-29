import BaseController from "../base_controller";

export default class extends BaseController {
  static targets = [
    'attachmentPreviews',
    'fileInput',
    'formSubmit'
  ]

  clickFileInput() {
    this.fileInputTarget.click()
  }

  preview() {
    this.clearPreviews();
    for (let i = 0; i < this.fileInputTarget.files.length; i++) {
      let file = this.fileInputTarget.files[i];
      const reader = new FileReader();
      this.createAndDisplayFilePreviewElements(file, reader);
    }
    this.attachmentPreviewsTarget.classList.remove("hidden");
  }

  toggleVisibility() {
    this.attachmentPreviewsTarget.classList.toggle("hidden");
  }

  appendInputFileHiddenToForm(file) {
    const reader = new FileReader();
    this.createAndDisplayFilePreviewElements(file, reader);

    const dataTransfer = new DataTransfer()
    dataTransfer.items.add(file)

    const hiddenFile = document.createElement("input")
    hiddenFile.setAttribute("type", "file")
    hiddenFile.classList.add('hidden')
    hiddenFile.files = dataTransfer.files;
    hiddenFile.name = this.fileInputTarget.name

    this.formSubmitTarget.appendChild(hiddenFile)
  }

  pasteImage(event) {
    const file = event?.clipboardData?.files?.[0];
    if (!file || !file.type.startsWith("image")) return;

    this.appendInputFileHiddenToForm(file)
  }

  createAndDisplayFilePreviewElements(file, reader) {
    reader.onload = () => {
      let element = this.constructPreviews(file, reader);
      element.src = reader.result;
      element.setAttribute("href", reader.result);
      element.setAttribute("target", "_blank");
      element.classList.add("attachment-preview");

      this.attachmentPreviewsTarget.appendChild(element);
    };
    reader.readAsDataURL(file);
  }

  constructPreviews(file, reader) {
    let element;
    let cancelFunction = (e) => this.removePreview(e);
    console.log("file.type: ", file.type)
    switch (file.type) {
      case "image/jpeg":
      case "image/jpg":
      case "image/svg+xml":
      case "image/png":
      case "image/gif":
        element = this.createImageElement(cancelFunction, reader);
        break;
      case "video/mp4":
      case "video/quicktime":
        element = this.createVideoElement(cancelFunction);
        break;
      case "audio/mpeg":
      case "audio/mp3":
      case "audio/wav":
        element = this.createAudioElement(cancelFunction);
        break;
      default:
        element = this.createDefaultElement(cancelFunction);
    }
    element.dataset.filename = file.name;
    return element;
  }

  createSvg(d, classList = []) {
    const svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
    this.setAttributes(svg, {
      "xmlns": "http://www.w3.org/2000/svg",
      "version": "1.1",
      "fill": "none",
      "viewBox": "0 0 24 24",
      "stroke-width": "1.5",
      "stroke": "currentColor"
    })

    classList.forEach(className => {
      svg.classList.add(className);
    })

    const pathElement = document.createElementNS("http://www.w3.org/2000/svg", "path");
    this.setAttributes(pathElement, {
      "stroke-linecap": "round",
      "stroke-linejoin": "round",
      "d": d
    })

    svg.appendChild(pathElement)

    return svg
  }

  createCancelButton(cancelFunction) {
    const cancelUploadButton = this.createSvg(
      "M9.75 9.75l4.5 4.5m0-4.5l-4.5 4.5M21 12a9 9 0 11-18 0 9 9 0 0118 0z",
      ["cancel-upload-button", "w-6", "h-6"]
    )

    cancelUploadButton.onclick = cancelFunction;

    return cancelUploadButton
  }

  createImageElement(cancelFunction, reader) {
    let cancelUploadButton, element;

    const image = document.createElement("img");
    image.setAttribute("src", reader.result);
    image.classList.add("preview-image");
    element = document.createElement("div");
    element.classList.add("attachment-image-container", "file-removal");
    element.appendChild(image);

    cancelUploadButton = this.createCancelButton(cancelFunction)

    element.appendChild(cancelUploadButton);
    return element;
  }

  createAudioElement(cancelFunction) {
    let cancelUploadButton, element;

    const audioSvg = this.createSvg(
      "M12 18.75a6 6 0 006-6v-1.5m-6 7.5a6 6 0 01-6-6v-1.5m6 7.5v3.75m-3.75 0h7.5M12 15.75a3 3 0 01-3-3V4.5a3 3 0 116 0v8.25a3 3 0 01-3 3z",
      ["w-full", "h-full"]
    )

    element = document.createElement("div");
    element.classList.add("audio-preview-icon", "file-removal");
    element.appendChild(audioSvg);

    cancelUploadButton = this.createCancelButton(cancelFunction)

    element.appendChild(cancelUploadButton);
    return element;
  }

  createVideoElement(cancelFunction) {
    let cancelUploadButton, element;

    const videoSvg = this.createSvg(
      "M15.75 10.5l4.72-4.72a.75.75 0 011.28.53v11.38a.75.75 0 01-1.28.53l-4.72-4.72M4.5 18.75h9a2.25 2.25 0 002.25-2.25v-9a2.25 2.25 0 00-2.25-2.25h-9A2.25 2.25 0 002.25 7.5v9a2.25 2.25 0 002.25 2.25z",
      ["w-full", "h-full"]
    )

    element = document.createElement("div");
    element.classList.add("video-preview-icon", "file-removal");
    element.appendChild(videoSvg);

    cancelUploadButton = this.createCancelButton(cancelFunction)

    element.appendChild(cancelUploadButton);
    return element;
  }

  createDefaultElement(cancelFunction) {
    let cancelUploadButton, element;

    const fileSvg = this.createSvg(
      "M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m2.25 0H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z",
      ["w-full", "h-full"]
    )

    element = document.createElement("div");
    element.classList.add("file-preview-icon", "file-removal");
    element.appendChild(fileSvg);

    cancelUploadButton = this.createCancelButton(cancelFunction)

    element.appendChild(cancelUploadButton);
    return element;
  }

  removePreview(event) {
    const target = event.target.parentNode.closest(".attachment-preview");
    const dataTransfer = new DataTransfer();
    let files = this.fileInputTarget.files;
    let filesArray = Array.from(files);

    filesArray = filesArray.filter((file) => {
      let filename = target.dataset.filename;
      return file.name !== filename;
    });
    target.parentNode.removeChild(target);
    filesArray.forEach((file) => dataTransfer.items.add(file));
    this.fileInputTarget.files = dataTransfer.files;

    if (filesArray.length === 0) {
      this.toggleVisibility();
    }
  }

  clearPreviews() {
    this.attachmentPreviewsTarget.innerHTML = "";
  }
}
