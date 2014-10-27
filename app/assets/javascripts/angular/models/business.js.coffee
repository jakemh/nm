angular.module("NM").factory "Business", [
  "Restangular"
  (Restangular) ->
    Restangular.extendModel "businesses", (model) ->
  
      model.messages = ->
        Restangular.several("messages", model.business.sent_message_ids).getList()

      return model
]