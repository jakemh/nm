angular.module("NM").factory "Post", [
  
  "$q"
  "MessageBase"
  "RestangularPlus"
  "Restangular"

  ($q, MessageBase, RestangularPlus, Restangular) ->
    # alert JSON.stringify Message
    Restangular.extendModel "posts", (model) ->

      model.entity = (params)->
        MessageBase.entity(model, params)
        # RestangularPlus.one()

      model.responses = ->
        if model.response_ids.length > 0
          Restangular.several("me/responses", model.response_ids).getList()
        else $q.when([])

      return model
      # model.messages = ->
      #   Restangular.several("messages", model.user.sent_message_ids).getList()

]