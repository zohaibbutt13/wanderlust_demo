document.addEventListener("turbo:load", function () {
  const flashMessages = document.querySelectorAll('.flash-message');

  flashMessages.forEach(function (message) {
    message.classList.add('show');

    if (message.classList.contains('notice')) {
      setTimeout(function () {
        message.classList.add('hide');
      }, 5000);
    }

    const closeBtn = message.querySelector('.flash-close');
    if (closeBtn) {
      closeBtn.addEventListener('click', function (e) {
        e.stopPropagation();
        message.classList.add('hide');
      });
    }
  });
});
