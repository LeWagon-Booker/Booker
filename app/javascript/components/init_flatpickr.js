
const toggleDateInputs = function() {
// First we define two variables that are going to grab our inputs field. You can check the ids of the inputs with the Chrome inspector.
const startDateInput = document.getElementById('reservation_start_date');
const endDateInput = document.getElementById('reservation_end_date');

// Check that the query selector id matches the one you put around your form.
if (startDateInput) {
const unavailableDates = JSON.parse(document.querySelector('#book-reservation').dataset.unavailable)
endDateInput.disabled = true

flatpickr(startDateInput, {
  minDate: "today",
  disable: unavailableDates,
  dateFormat: "d/m/Y",
});

console.log('im in the file')

startDateInput.addEventListener("change", (e) => {
  if (startDateInput != "") {
    endDateInput.disabled = false
  }
  flatpickr(endDateInput, {
    minDate: e.target.value,
    disable: unavailableDates,
    dateFormat: "d/m/Y"
    });
  })
};

};

export { toggleDateInputs }

