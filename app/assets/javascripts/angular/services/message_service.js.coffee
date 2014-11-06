
App.factory "MessageService", [
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

    sendMessage: ()->

]
