angular.module("NM").factory "User", [
  "$q"
  "Restangular"
  ($q, Restangular) ->
    Restangular.extendModel "users", (model) ->
      model.businesses = ->
        if model.user.business_ids.length > 0
          Restangular.several("businesses", model.user.business_ids).getList()
        else $q.when([])
      # model.messages = ->
      #   Restangular.several("me/messages", model.user.sent_message_ids).getList()

      model.sentMmessages = ->
        if model.user.sent_message_ids.length > 0

          Restangular.several("me/sent_messages", model.user.sent_message_ids).getList()
        else $q.when([])


      model.receivedMessages = ->
        if model.user.received_messages_ids.length > 0
          Restangular.several("me/received_messages", model.user.received_message_ids).getList()
        else $$q.when([])

      model.posts = ->
        if model.user.post_ids.length > 0
          Restangular.several("me/posts", model.user.post_ids).getList()
        else $q.when([])

      return model
]