


const reservationForm = function() {

  const selectElement = document.querySelector('.name');
  if (selectElement) {
    selectElement.addEventListener('change', (event) => {
    console.log(event.target.value);
    document.querySelectorAll(".form-reservation-container").forEach((div)=> {
      div.classList.add("hidden")
    })
    const id = event.target.value
    const div = document.getElementById(id)
    div.classList.remove("hidden")
    });
  }


}

export {reservationForm}
