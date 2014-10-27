angular.module("NM").factory "Entity", [
  "Restangular"
  (Restangular) ->
    Restangular.extendModel "entities", (model) ->
  
      model.messages = ->
        Restangular.several("messages", model.entity.sent_message_ids).getList()

      return model
]