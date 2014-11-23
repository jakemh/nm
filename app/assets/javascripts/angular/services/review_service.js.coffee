App.factory "ReviewService", [
  "$q"
  "CacheService"
  "Restangular"
  ($q, CacheService, Restangular) ->
    messageEntity: null
    
    setMessageEntity: (entity)->
      @messageEntity = entity

    callModal: (id, $event)->
      $("#" + id).modal()
      return true

    # sendMessage: ()->

    submit: (model, entity, entryForm, callback) ->
      if entryForm.$valid
        entryForm.hasError = false;
        callback(entity, model)
        model.content = ""
      else 
        entryForm.hasError = true

]
