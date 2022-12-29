import Dropzone from "dropzone";
import { DirectUpload } from "@rails/activestorage";
import {
  getMetaValue,
  findElement,
  removeElement,
  insertAfter,
} from "../helpers/common";
import BaseController from "../base_controller";

export default class extends BaseController {
  static targets = ["input"];

  get flashMessagesController() {
    return this.findController("flash-messages", "components--flash-messages")
  }

  connect() {
    console.log("Connected to the dropzone controller");

    this.dropZone = createDropZone(this);
    this.hideFileInput();
    this.bindEvents();

    Dropzone.autoDiscover = false; // necessary quirk for Dropzone error in console
  }

  hideFileInput() {
    this.inputTarget.style.display = "none";
  }

  bindEvents() {
    const currentController = this;

    this.dropZone.on("addedfile", (file) => {
      if (currentController.dropZone.files.length > currentController.maxFiles) {
        currentController.dropZone.removeFile(currentController.dropZone.files[0])
      }

      setTimeout(() => {
        file.accepted && createDirectUploadController(this, file).start();
      }, 500);
    });

    // Don't use this event because we have already handled preview file deletion in controller file-preview
    this.dropZone.on("removedfile", (file) => {
      file.controller && removeElement(file.controller.hiddenInput);
    });

    this.dropZone.on("canceled", (file) => {
      file.controller && file.controller.xhr.abort();
    });

    this.dropZone.on("processing", (file) => {});

    this.dropZone.on("queuecomplete", (file) => {});

    this.dropZone.on("success", (file) => {
      let container = new DataTransfer()
      container.items.add(file)

      Array.from(currentController.inputTarget.files).forEach(oldFile => {
        container.items.add(oldFile)
      });

      this.inputTarget.files = container.files
      this.inputTarget.dispatchEvent(new Event("change"))
    });

    this.dropZone.on("complete", file => {});

    this.dropZone.on('error', function(file, error) {
      currentController.flashMessagesController.flashesValue = [['error', error]]
      currentController.flashMessagesController.showFlashMessages()
    })
  }

  get headers() {
    return { "X-CSRF-Token": getMetaValue("csrf-token") };
  }

  get url() {
    return this.inputTarget.getAttribute("data-direct-upload-url");
  }

  get maxFiles() {
    return this.data.get("maxFiles") || 1;
  }

  get maxFileSize() {
    return this.data.get("maxFileSize") || 256;
  }

  get acceptedFiles() {
    return this.data.get("acceptedFiles");
  }

  get addRemoveLinks() {
    return this.data.get("addRemoveLinks") || true;
  }

  get uploadMultiple() {
    return this.data.get("uploadMultiple") || false;
  }
}

class DirectUploadController {
  constructor(source, file) {
    this.directUpload = createDirectUpload(file, source.url, this);
    this.source = source;
    this.file = file;
  }

  start() {
    this.file.controller = this;

    // don't make the input hidden because we used DataTransfer to reset the input's files
    // this.hiddenInput = this.createHiddenInput();
    this.directUpload.create((error, attributes) => {
      if (error) {
        // removeElement(this.hiddenInput);
        this.emitDropzoneError(error);
      } else {
        // this.hiddenInput.value = attributes.signed_id;
        this.emitDropzoneSuccess();
      }
    });
  }

  createHiddenInput() {
    const input = document.createElement("input");
    input.type = "hidden";
    input.name = this.source.inputTarget.name;
    insertAfter(input, this.source.inputTarget);

    return input;
  }

  directUploadWillStoreFileWithXHR(xhr) {
    this.bindProgressEvent(xhr);
    this.emitDropzoneUploading();
  }

  bindProgressEvent(xhr) {
    this.xhr = xhr;
    this.xhr.upload.addEventListener("progress", (event) => {
      // not used because previewsContainer = false
      // this.uploadRequestDidProgress(event)
    });
  }

  uploadRequestDidProgress(event) {
    const element = this.source.element;
    const progress = (event.loaded / event.total) * 100;
    findElement(
      this.file.previewTemplate,
      ".dz-upload"
    ).style.width = `${progress}%`;
  }

  emitDropzoneUploading() {
    this.file.status = Dropzone.UPLOADING;
    this.source.dropZone.emit("processing", this.file);
  }

  emitDropzoneError(error) {
    this.file.status = Dropzone.ERROR;
    this.source.dropZone.emit("error", this.file, error);
    this.source.dropZone.emit("complete", this.file);
  }

  emitDropzoneSuccess() {
    this.file.status = Dropzone.SUCCESS;
    this.source.dropZone.emit("success", this.file);
    this.source.dropZone.emit("complete", this.file);
  }
}

function createDirectUploadController(source, file) {
  return new DirectUploadController(source, file);
}

function createDirectUpload(file, url, controller) {
  return new DirectUpload(file, url, controller);
}

function createDropZone(controller) {
  let dropzone = new Dropzone(controller.element, {
    url: controller.url,
    headers: controller.headers,
    maxFiles: controller.maxFiles,
    maxFilesize: controller.maxFileSize,
    // acceptedFiles: controller.acceptedFiles,
    addRemoveLinks: controller.addRemoveLinks,
    uploadMultiple: controller.uploadMultiple,
    autoQueue: false,
    createImageThumbnails: false,
    previewsContainer: false,
  });

  console.log(dropzone);

  return dropzone;
}
