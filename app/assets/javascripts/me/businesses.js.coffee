ready = undefined
ready = ->
  $('#js-business-tags').tagsInput();
  # $('#js-industry-select').select2();
$(document).ready ready
$(document).on "page:load", ready