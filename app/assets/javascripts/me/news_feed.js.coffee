ready = undefined
ready = ->

  $(".feed__entry-select").change ->
    # alert $(@).val()
    img = JSON.parse($(@).val())[2]
    # alert $(".feed__entry-inner--left img").attr("src")
    $(".feed__entry-inner--left img").attr("src",img)
$(document).ready ready
$(document).on "page:load", ready

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
