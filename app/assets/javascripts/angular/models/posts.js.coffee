angular.module("NM").factory "Post", [
  "Restangular"
  (Restangular) ->
    Restangular.extendModel "posts", (model) ->
  
      # model.messages = ->
      #   Restangular.several("messages", model.user.sent_message_ids).getList()

      return model
]