angular.module("NM").factory "User", [
  "$q"
  "Restangular"
  "Entity"
  ($q, Restangular, Entity) ->

    Restangular.extendModel "users", (model) =>
      model.businesses = ->
        if model.business_ids.length > 1
          Restangular.several("businesses", model.business_ids).getList()
        else if model.business_ids.length == 1
          Restangular.one("businesses", model.business_ids).get()
        else $q.when([])
      # model.messages = ->
      #   Restangular.several("me/messages", model.user.sent_message_ids).getList()

      model.sentMessages = ->
        if model.sent_message_ids.length > 0
          Restangular.several("me/sent_messages", model.sent_message_ids).getList()
        else $q.when([])


      model.receivedMessages = ->
        if model.received_message_ids.length > 0
          Restangular.several("me/received_messages", model.received_message_ids).getList()
        else $q.when([])

      model.posts = =>
        # if model.post_ids.length > 0
        #   Restangular.several("me/posts", model.post_ids).getList()
        # else $q.when([])
        Restangular.all("me/posts").getList()

      model.followers = ->
        if model.follower_ids.length > 0
          Restangular.all("me/followers").getList({entity_id: model.id, entity_type: model.type})
        else $q.when([])

      return model
]