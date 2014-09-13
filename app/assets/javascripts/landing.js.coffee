ready = undefined
ready = ->
  email = null

  $("#email-submit").submit (e)->
    email = $("#email-field-landing").val()
    e.preventDefault()

    $.ajax(
      url:  $(this).attr('action')
      type: "post"
      async: true
      data: $(this).serialize()
      dataType: "script"
      beforeSend: (xhr) ->
        xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
    ).fail((error) ->
      
    ).success ->
      $("#sign-up-modal").modal()
      $("#sign-up-modal").on("shown.bs.modal", ->
        $("#email-field-modal").val(email)
        $("#first-name").focus()
      )

  # $("#new_user").submit (e)->
  #   e.preventDefault()

  #   $.ajax(
  #     url: "/users"
  #     type: "post"
  #     async: true
  #     data: $(this).serialize()
  #     dataType: "script"
  #     beforeSend: (xhr) ->
  #       xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
  #   ).fail((error) ->
  #     alert "FAILS"
  #   ).success( ->
  #     window.location = "/"
  #   ).always ->
    
    

$(document).ready ready
$(document).on "page:load", ready