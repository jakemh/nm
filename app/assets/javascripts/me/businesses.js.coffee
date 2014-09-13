ready = undefined
ready = ->
  $('#js-business-tags').tagsInput();
$(document).ready ready
$(document).on "page:load", ready