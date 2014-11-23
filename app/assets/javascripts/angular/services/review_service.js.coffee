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
    # # sendMessage: ()->

    # newPost:  
    # entity: 

    submit: (model, entity, entryForm, callback) ->
      if entryForm.$valid
        entryForm.hasError = false;
        callback(entity, model)
        model.content = ""
      else 
        entryForm.hasError = true

]
