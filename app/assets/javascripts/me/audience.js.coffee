ready = undefined
ready = ->

  AudienceController = Paloma.controller('Me/Audience');
  AudienceController.prototype.index = ->
    
    $(".aud__entry-select").select2()
    $(".feed__entry-select").change ->
      value = JSON.parse($(@).val())
      idVal = value[1]

      form = $("#js-aud__business-form")
      $.ajax(
        url:  form.attr('action')
        type: "get"
        async: true
        data: jQuery.param({business_id: idVal})
        dataType: "script"
        beforeSend: (xhr) ->
          xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
      ).fail((error) ->
      ).success ->
    


$(document).ready ready
$(document).on "page:load", ready

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
