angular.module("NM").factory "Business", [
  "$q"
  "Restangular"
  "RestangularPlus"
  ($q, Restangular, RestangularPlus) ->
    Restangular.extendModel "businesses", (model) ->
      angular.extend self, RestangularPlus
      self.sentMessages = ->
          self.getListPlus("sent_messages", {all: true})
          # Restangular.severalPlus"sent_messages", self.sent_message_ids).getList()
          # Restangular.several("me/sent_messages", self.sent_message_ids).getList()


      self.receivedMessages = ->
        self.getListPlus("received_messages", {all: true})
          # Restangular.severalPlus(self, "received_messages", self.received_message_ids).getList()
      
      
      self.followers = ->
          self.getListPlus("followers", {entity_id: self.id, entity_type: self.type})

      self.personalPosts = ->
        self.severalPlus("posts").getList()


      model.posts = (params)->
        # if model.post_ids.length > 0
        #   Restangular.several("me/posts", model.post_ids).getList()
        # else $q.when([])
        model.getList("posts", params)
        # model.several('posts',[2,3,4]).getList()
        # Restangular.all("me/posts").getList()


      return model
]