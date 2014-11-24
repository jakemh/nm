"use strict";

App.factory "ReviewService", [
  "$q"
  "CacheService"
  "Restangular"
  ($q, CacheService, Restangular) ->
    messageEntity: null
    
    # setMessageEntity: (entity)->
    #   @messageEntity = entity

    callModal: ()->
      $("#js__business-review-modal").modal()
      return true

    hideModal: ()->
      $("#js__business-review-modal").modal('hide')
      return true

    # # sendMessage: ()->

    # newPost: {}
    # entity: null
    rateFunction: (rating) ->
      # alert "Rating selected - " + rating
      return
    
   
    sendPost: (business, post)->
      business.review(post).then (response) =>
        $("#js__business-review-modal").modal('hide')
    # submit: (model, entity, entryForm, callback) ->
    #   alert JSON.stringify model
    #   if entryForm.$valid
    #     entryForm.hasError = false;
    #     callback(entity, model)
    #     model.content = ""
    #   else 
    #     entryForm.hasError = true

]
