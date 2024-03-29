import flatpickr from 'flatpickr';

const toggleDateInputs = function() {
// First we define two variables that are going to grab our inputs field. You can check the ids of the inputs with the Chrome inspector.
const dates = document.querySelectorAll(".date")
dates.forEach((datediv) => {
const startDateInput = datediv.querySelector('#reservation_start_date');
const endDateInput = datediv.querySelector('#reservation_end_date');

// Check that the query selector id matches the one you put around your form.
if (startDateInput) {
const unavailableDates = JSON.parse(datediv.dataset.unavailable)
endDateInput.disabled = true

flatpickr(startDateInput, {
  minDate: "today",
  disable: unavailableDates,
  dateFormat: "d/m/Y",
});

startDateInput.addEventListener("change", (e) => {

  if (startDateInput != "") {
    endDateInput.disabled = false
  }

  let dateParts = e.target.value.split("/");
  let dateObject = new Date(+dateParts[2], dateParts[1] - 1, +dateParts[0]);

  flatpickr(endDateInput, {
    minDate: dateObject,
    disable: unavailableDates,
    dateFormat: "d/m/Y"
    });
  })
};
})
};

export { toggleDateInputs }

