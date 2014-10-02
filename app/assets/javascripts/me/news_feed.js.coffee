ready = undefined
ready = ->

  $(".feed__entry-select").change ->
    # alert $(@).val()
    value = JSON.parse($(@).val())
    idVal = value[1]
    img = value[2]
    objType = value[0]
    name = value[3]
    action = null
    if objType == "Business"
      action = "/me/businesses/" + idVal + "/posts"
    else if objType == "User"
      action = "me/posts"

    $("#js-post-form").attr("action", action);
    # alert $(".feed__entry-inner--left img").attr("src")
    $(".feed__entry-inner--left img").attr("src",img)
    $(".js-form-name").html(name)
$(document).ready ready
$(document).on "page:load", ready

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
