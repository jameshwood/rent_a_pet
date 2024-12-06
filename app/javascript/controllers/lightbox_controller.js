import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["photo", "lightbox", "lightboxImage"];

  open(event) {
    const photoElement = event.target;
    this.currentIndex = parseInt(photoElement.dataset.index, 10); // Get the index of the clicked image
    this.photos = Array.from(this.photoTargets).map((photo) => photo.src); // Collect photo URLs from targets

    // Show the lightbox and display the clicked photo
    this.lightboxTarget.classList.remove("hidden");
    this.lightboxTarget.style.display = "flex";
    this.updateLightboxImage();
  }

  close() {
    this.lightboxTarget.classList.add("hidden");
    this.lightboxTarget.style.display = "none";
  }

  next() {
    // Navigate to the next photo
    this.currentIndex = (this.currentIndex + 1) % this.photos.length;
    this.updateLightboxImage();
  }

  prev() {
    // Navigate to the previous photo
    this.currentIndex =
      (this.currentIndex - 1 + this.photos.length) % this.photos.length;
    this.updateLightboxImage();
  }

  updateLightboxImage() {
    // Update the lightbox image with the current photo
    this.lightboxImageTarget.src = this.photos[this.currentIndex];
  }
}
