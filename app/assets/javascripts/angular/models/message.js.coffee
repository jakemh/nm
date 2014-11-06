angular.module("NM").factory "ReceivedMessage", [

  "$q"
  "MessageBase"
  "Restangular"
  "RestangularPlus"

  ($q, MessageBase, Restangular, RestangularPlus) ->
    Restangular.extendModel "received_messages", (self) ->
      angular.extend self, RestangularPlus
  
      self.entity = ->
        MessageBase.entity(self)

      self.responses = ->
        self.getListPlus("message_responses")

        # MessageBase.entity(self)

      return self
     # responses: (model) ->
     #   if model.response_ids.length > 0
     #     Restangular.several("me/message_responses", model.response_ids).getList()
     #   else $q.when([])
]

angular.module("NM").factory "SentMessage", [
 
  "$q"
  "MessageBase"
  "Restangular"
  "RestangularPlus"

  ($q, MessageBase, Restangular, RestangularPlus) ->
    Restangular.extendModel "sent_messages", (self) ->
      angular.extend self, RestangularPlus

      self.entity = ->
        MessageBase.entity(self)

      self.responses = ->
        self.getListPlus("message_responses")

        # if model.response_ids.length > 0
        #   Restangular.several("message_responses", model.response_ids).getList()
        # else $q.when([])

      return self

    # return Message
]

angular.module("NM").factory "MessageResponse", [
  "$q"
  "MessageBase"
  "Restangular"
  "RestangularPlus"

  ($q, MessageBase, Restangular, RestangularPlus) ->
    Restangular.extendModel "message_responses", (self) ->
      angular.extend self, RestangularPlus

      self.entity = ->
        MessageBase.entity(self)

      self.responses = ->
        self.getListPlus("message_responses")

        # if model.response_ids.length > 0
        #   # self.several("message_responses", model.response_ids).getList()
        # else $q.when([])
   
      return self

    # return Message
]