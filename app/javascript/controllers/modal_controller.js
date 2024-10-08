import { Controller } from "@hotwired/stimulus"

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
