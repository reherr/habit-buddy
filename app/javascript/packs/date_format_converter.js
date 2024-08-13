document.addEventListener('DOMContentLoaded', function () {
  const form = document.querySelector('form[data-date-format]');
  if (form) {
    form.addEventListener('submit', function (event) {
      const dateField = form.querySelector('input[name="q[entry_date_eq]"]');
      if (dateField) {
        const dateValue = dateField.value;
        const [month, day, year] = dateValue.split('-');
        if (month && day && year && month.length === 2 && day.length === 2 && year.length === 4) {
          dateField.value = `${year}-${month}-${day}`;
        } else {
          // Optional: Add error handling if the date format is incorrect
          alert('Please enter the date in MM-DD-YYYY format.');
          event.preventDefault();
        }
      }
    });
  }
});
