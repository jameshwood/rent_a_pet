import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

export default class extends Controller {
  static targets = ["start", "end"]
  static values = { bookedDates: Array }

  connect() {
    const bookedRanges = this.bookedDatesValue.map(range => ({
      from: new Date(range.from),
      to: new Date(range.to)
    }))

    // Initialize Flatpickr for start date
    flatpickr(this.startTarget, {
      minDate: "today",
      disable: bookedRanges,
      dateFormat: "Y-m-d"
    })

    // Initialize Flatpickr for end date
    flatpickr(this.endTarget, {
      minDate: "today",
      disable: bookedRanges,
      dateFormat: "Y-m-d"
    })
  }
}
