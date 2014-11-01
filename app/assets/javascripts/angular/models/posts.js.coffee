angular.module("NM").factory "Post", [
  
  "$q"
  "MessageBase"
  "Restangular"

  ($q, MessageBase, Restangular) ->
    # alert JSON.stringify Message
    Restangular.extendModel "posts", (model) ->

      model.entity = ->
        MessageBase.entity(model)

      model.responses = ->
        if model.response_ids.length > 0
          Restangular.several("me/responses", model.response_ids).getList()
        else $q.when([])

      return model
      # model.messages = ->
      #   Restangular.several("messages", model.user.sent_message_ids).getList()

]