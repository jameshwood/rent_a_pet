import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["start", "end", "price"];
  static values = { bookedDates: Array, pricePerDay: Number };

  connect() {
    const bookedRanges = this.bookedDatesValue.map((range) => ({
      from: new Date(range.from),
      to: new Date(range.to),
    }));

    // Initialize Flatpickr for start date
    this.startPicker = flatpickr(this.startTarget, {
      minDate: "today",
      disable: bookedRanges,
      dateFormat: "Y-m-d",
      onChange: (selectedDates) => {
        this.updateEndPicker(selectedDates[0]); // Update the end picker based on the selected start date
        this.updatePrice();
      },
    });

    // Initialize Flatpickr for end date
    this.endPicker = flatpickr(this.endTarget, {
      minDate: "today",
      disable: bookedRanges,
      dateFormat: "Y-m-d",
      onChange: () => this.updatePrice(),
    });

    this.updatePrice();
  }

  updateEndPicker(startDate) {
    if (!startDate) return;

    // Set the new minimum date for the end date picker
    this.endPicker.set("minDate", startDate);

    // Set the defaultDate to the start date so it is pre-selected and circled
    this.endPicker.setDate(startDate, true);

    // Ensure the disabled dates are carried forward
    this.endPicker.set(
      "disable",
      this.bookedDatesValue.map((range) => ({
        from: new Date(range.from),
        to: new Date(range.to),
      }))
    );

    // Automatically open the end date picker
    this.endPicker.open();
  }

  updatePrice() {
    const startDate = new Date(this.startTarget.value);
    const endDate = new Date(this.endTarget.value);

    if (this.isValidDate(startDate) && this.isValidDate(endDate) && startDate <= endDate) {
      const timeDifference = endDate - startDate;
      const days = Math.ceil(timeDifference / (1000 * 60 * 60 * 24)) + 1; // Add 1 to include the last day
      const totalPrice = days * this.pricePerDayValue;
      this.priceTarget.textContent = `£${totalPrice.toFixed(2)}`;
    } else {
      this.priceTarget.textContent = "£0.00";
    }
  }

  isValidDate(date) {
    return date instanceof Date && !isNaN(date);
  }
}
