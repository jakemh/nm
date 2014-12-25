angular.module("NM").factory "Post", [
  
  "$q"
  "MessageBase"
  "RestangularPlus"
  "Restangular"

  ($q, MessageBase, RestangularPlus, Restangular) ->
    # alert JSON.stringify Message
    Restangular.extendModel "posts", (self) =>
      angular.extend self, MessageBase

      # model.entity = (params)->
      #   MessageBase.entity(model, params)
        # RestangularPlus.one()
      self.getPoints = () ->
        self.points || 0

      self.responses = ->
        if self.response_ids.length > 0
          Restangular.several("me/responses", self.response_ids).getList()
        else $q.when([])

      return self
      # model.messages = ->
      #   Restangular.several("messages", model.user.sent_message_ids).getList()

]