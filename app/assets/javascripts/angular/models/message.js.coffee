angular.module("NM").factory "ReceivedMessage", [
  "MessageBase"
  "Restangular"

  (MessageBase, Restangular) ->
    Restangular.extendModel "received_messages", (model) ->
        
      model.entity = ->
        MessageBase.entity(model)

      model.responses = ->
        MessageBase.entity(model)

      return model
     # responses: (model) ->
     #   if model.response_ids.length > 0
     #     Restangular.several("me/message_responses", model.response_ids).getList()
     #   else $q.when([])
]

angular.module("NM").factory "SentMessage", [
  "$q"
  "MessageBase"
  "Restangular"

  ($q, MessageBase, Restangular) ->
    Restangular.extendModel "sent_messages", (model) ->
      
      model.entity = ->
        MessageBase.entity(model)

      model.responses = ->
        if model.response_ids.length > 0
          Restangular.several("message_responses", model.response_ids).getList()
        else $q.when([])

      return model

    # return Message
]

angular.module("NM").factory "MessageResponse", [
  "$q"
  "MessageBase"
  "Restangular"

  ($q, MessageBase, Restangular) ->
    Restangular.extendModel "message_responses", (model) ->
      
      model.entity = ->
        MessageBase.entity(model)

      model.responses = ->
        if model.response_ids.length > 0
          Restangular.several("message_responses", model.response_ids).getList()
        else $q.when([])
   
      return model

    # return Message
]