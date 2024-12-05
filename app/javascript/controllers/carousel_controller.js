import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // Find all carousels in the grid
    this.element.querySelectorAll('.carousel').forEach(carousel => {
      const shouldInitialize = carousel.dataset.carousel === "true";

      if (shouldInitialize) {
        // Initialize the carousel with Bootstrap
        const bootstrapCarousel = new bootstrap.Carousel(carousel, {
          interval: 3000, // Adjust interval as needed
          ride: 'carousel',
        });
      } else {
        // Hide controls for single image
        carousel.querySelectorAll('.carousel-control-prev, .carousel-control-next').forEach(control => {
          control.style.display = 'none';
        });
      }
    });
  }
}

