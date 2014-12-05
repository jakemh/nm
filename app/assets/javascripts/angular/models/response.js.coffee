angular.module("NM").factory "Response", [
  "$q"
  "UsersCache"
  "BusinessesCache"
  "Restangular"
  "MessageBase"
  ($q, UsersCache, BusinessesCache, Restangular, MessageBase) ->
    Restangular.extendModel "me/responses", (self) ->
      angular.extend self, MessageBase
            

      return self
      # model.messages = ->
      #   Restangular.several("messages", model.user.sent_message_ids).getList()

]