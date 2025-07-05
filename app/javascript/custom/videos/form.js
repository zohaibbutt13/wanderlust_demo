document.addEventListener("turbo:load", function () {
  videoCardSelection();
  paymentFormSubmission();
  openPaymentForm();
  submitPaymentForm();

  function videoCardSelection () {
    const videoCards = document.querySelectorAll('.video-card');
    
    videoCards.forEach(card => {
      card.addEventListener('click', function () {
        const checkbox = this.querySelector('.video-checkbox');
        if (checkbox) {
          checkbox.checked = !checkbox.checked;
        }

        this.classList.toggle('selected');
      });
    });
  }

  function paymentFormSubmission() {
    const form = document.getElementById("paymentForm");

    if(form) {
      form.addEventListener("submit", function (event) {
        if (!form.checkValidity()) {
          event.preventDefault();
          event.stopPropagation();
        }

        form.classList.add("was-validated");
      });
    }
  }

  function openPaymentForm() {
    const openModalBtn = document.getElementById("make_a_payment_btn");

    if (openModalBtn) {
      openModalBtn.addEventListener("click", () => {
        const form = document.getElementById('prject_form');

        if (form.checkValidity()) {
          const cost = collectPaymentCostHelper();
          const modalElement = document.getElementById("payment_modal");
          document.getElementById('amount').value = cost;
          const modal = new bootstrap.Modal(modalElement);
          modal.show();
        }

        form.classList.add("was-validated");
      });
    }
  }

  function submitPaymentForm() {
    const submitBtn = document.getElementById('payment_form_submit_btn');

    if(submitBtn) {
      submitBtn.addEventListener('click', () => {
        document.getElementById('prject_form').submit();
      })
    }
  }
});

function collectPaymentCostHelper() {
  const checkboxes = document.querySelectorAll('input[type="checkbox"].js-video-checkbox');

  let totalCost = 0;
  checkboxes.forEach(checkbox => {
    if (checkbox.checked) {
      const cost = checkbox.dataset.cost;
      totalCost = totalCost + +cost;
    }
  });

  return totalCost;
}
