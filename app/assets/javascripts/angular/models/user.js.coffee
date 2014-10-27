angular.module("NM").factory "User", [
  "Restangular"
  (Restangular) ->
    Restangular.extendModel "users", (model) ->
      model.businesses = ->
        Restangular.several("businesses", model.user.business_ids).getList()

      model.messages = ->
        Restangular.several("me/messages", model.user.sent_message_ids).getList()

      return model
]