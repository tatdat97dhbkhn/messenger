import BaseController from "../base_controller";

export default class extends BaseController {
  toggleSidebar() {
    const sidebarTarget = document.getElementById('application_sidebar')
    sidebarTarget.classList.toggle('hidden')
  }

  toggleChatSidebar() {
    const sidebarTarget = document.getElementById('chat-sidebar')
    sidebarTarget.classList.toggle('hidden')
  }
}
