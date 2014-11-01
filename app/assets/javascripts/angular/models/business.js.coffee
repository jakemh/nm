angular.module("NM").factory "Business", [
  "$q"
  "Restangular"
  ($q, Restangular) ->
    Restangular.extendModel "businesses", (model) ->
      
      model.sentMessages = ->
        if model.sent_message_ids.length > 0
          Restangular.several("me/sent_messages", model.sent_message_ids).getList()
        else $q.when([])

      model.receivedMessages = ->
        if model.received_message_ids.length > 0
          Restangular.several("me/received_messages", model.received_message_ids).getList()
        else $$q.when([])

      model.followers = ->
        if model.follower_ids.length > 0
          Restangular.all("me/followers").getList({entity_id: model.id, entity_type: model.type})
        else $q.when([])


      model.posts = (params)->
        # if model.post_ids.length > 0
        #   Restangular.several("me/posts", model.post_ids).getList()
        # else $q.when([])
        model.getList("posts", params)
        # model.several('posts',[2,3,4]).getList()
        # Restangular.all("me/posts").getList()


      return model
]