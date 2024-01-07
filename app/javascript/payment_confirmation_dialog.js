window.addEventListener(('turbo:load'), () => {
  document.addEventListener('submit', (event) => {
    if (event.target && event.target.className === 'payment-alertbox') {
      event.preventDefault()
      Swal.fire({
          title: 'Czy na pewno chcesz potwierdzić płatność?',
          text: "Po kliknięciu zostaniesz przekierowany do strony płatności",
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Tak, potwierdzam.',
          cancelButtonText: 'Anuluj'
      })
        .then((result) => {
          if (result.isConfirmed) {
            document.querySelector('.payment-alertbox').submit()
          }
        })
        .catch(event.preventDefault())
    }
  })
})
