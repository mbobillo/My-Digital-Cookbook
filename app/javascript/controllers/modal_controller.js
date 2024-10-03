import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["imageContainer"];

  open() {
    const modal = new bootstrap.Modal(document.getElementById("imageModal"), {});
    modal.show();
  }

  close() {
    const modal = bootstrap.Modal.getInstance(document.getElementById("imageModal"));
    modal.hide();
  }
}
