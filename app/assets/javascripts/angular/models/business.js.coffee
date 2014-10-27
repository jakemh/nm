angular.module("NM").factory "Business", [
  "Restangular"
  (Restangular) ->
    Restangular.extendModel "businesses", (model) ->
  
      model.messages = ->
        if model.business.sent_message_ids.length > 0
          Restangular.several("messages", model.business.sent_message_ids).getList()
        else $q.when([])
      return model
]