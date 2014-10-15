# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = undefined
ready = ->
  $("#query").on("click", ->
    box = $(@).closest(".twitter-typeahead").find(".js-top-search")
    box.animate({width: "300px"})

    )
$(document).ready ready
$(document).on "page:load", ready