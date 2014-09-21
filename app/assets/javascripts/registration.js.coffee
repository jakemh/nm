ready = undefined
ready = ->

  if $(".check-container__form-reg .error").length > 0
    $('.check-label__form-reg').addClass("red-outline")


  $("#js-business-tags_tag").attr("placeholder", "ADD TAGS OR KEYWORDS (hit enter)")
  $("#js-business-tags_tag").css({"width": "100%"})
  $("#js-business-tags_tagsinput").css({"marginLeft": "-10px"})
$(document).ready ready
$(document).on "page:load", ready