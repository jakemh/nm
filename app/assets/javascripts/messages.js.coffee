ready = undefined
ready = ->
  source = null

  # if !!window.EventSource
  #   source = new EventSource('/me/send_data')

  # # Result to xhr polling :(
  # source.addEventListener "message", ((e) ->
  #   console.log e.data
  # ), false
  # source.addEventListener "open", ((e) ->

  # # Connection was opened.
  # ), false
  # source.addEventListener "error", ((e) ->
  #   e.readyState is EventSource.CLOSED

  # # Connection was closed.
  # ), false
  # MessagesController = Paloma.controller('Messages');

  # MeMessagesController = Paloma.controller('Me/Messages');

  $(".msg__entity-select").select2()
  $(".js-msg__button").on("click", (e) ->
    e.preventDefault()
    $("#js-msg__modal").modal()

    )


  $('.feed__content').linkify({}, ->
    );
  # $(".feed__entry-select").select2();

  $(".msg__entity-select").change ->
    value = JSON.parse($(@).val())
    objType = value[0]
    idVal = value[1]
    data = null
    if objType == "Business"
      data = {business_id: idVal}
    else if objType == "User"
      data = {user_id: idVal}

    $.ajax(
      type: "get"
      url: "/me/messages"
      async: true
      data: jQuery.param(data)
      dataType: "script"
      beforeSend: (xhr) ->
        xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
    ).fail((error) ->
      console.log JSON.stringify error
    ).success ->
      # alert "me/msg SUC"

    

  $(".feed__entry-select").change ->
    value = JSON.parse($(@).val())
    idVal = value[1]
    img = value[2]
    objType = value[0]
    name = value[3]
    action = null

    # if objType == "Business"
    #   action = "/me/businesses/" + idVal + "/messages"
    # else if objType == "User"
    #   action = "me/messages"

    # $("#js-post-form, #js-post-form-response").attr("action", action);
    # alert $(".feed__entry-inner--left img").attr("src")
    $(".feed__entry-inner--left img").attr("src",img)
    $(".js-form-name").html(name)
    
  $(".js-feed-comment").on("click", (e) ->
    e.preventDefault()
    commentElement = $(@).closest(".feed__content-outer").find(".feed__comment-input")
    commentElement.slideDown()
    )

$(document).ready ready
$(document).on "page:load", ready



# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
