$(function() {
  $(document).on('change', ':file', function() {
    var filename = event.target.files[0].name;
    var input = $(this).parents('.input-group').find(':text');
    input.val(filename);
  });
});
