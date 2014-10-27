angular.module("NM").factory "Entity", [
  "Restangular"
  (Restangular) ->
    Restangular.extendModel "entities", (model) ->
  
      model.messages = ->
        if model.entity.sent_message_ids.length > 0
          Restangular.several("messages", model.entity.sent_message_ids).getList()
        else $q.when([])

      return model
]