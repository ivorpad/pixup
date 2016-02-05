$(document).on('keydown', '#comment-form', function(e) {
  if(e.keyCode == 13 && (e.metaKey || e.ctrlKey)) {
    $(this).parents('form').submit()
  }
})
