

angular.module("NM").factory "ReceivedMessage", [
  "MessageBase"
  "Restangular"

  (MessageBase, Restangular) ->
    Restangular.extendModel "me/received_messages", (model) ->
        
      model.entity = ->
        MessageBase.entity(model)

      model.responses = ->
        MessageBase.entity(model)

      model.responses = ->
        MessageBase.entity(model)
      return model
]

angular.module("NM").factory "SentMessage", [
  "MessageBase"
  "Restangular"

  (MessageBase, Restangular) ->
    Restangular.extendModel "me/sent_messages", (model) ->
      
      model.entity = ->
        MessageBase.entity(model)

      model.responses = ->
        MessageBase.entity(model)

      return model

    # return Message
]