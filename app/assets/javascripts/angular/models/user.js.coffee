angular.module("NM").factory "User", [

  "$q"
  "Restangular"
  "RestangularPlus"
  "Entity"

  ($q, Restangular, RestangularPlus, Entity) ->
    Restangular.extendModel "users", (self) =>
      angular.extend self, RestangularPlus
      self.businesses = ->
        if self.business_ids.length > 1
          Restangular.several("businesses", self.business_ids).getList()
        else if self.business_ids.length == 1
          Restangular.one("businesses", self.business_ids).get()
        else $q.when([])
      # self.messages = ->
      #   Restangular.several("me/messages", self.user.sent_message_ids).getList()

      self.sentMessages = ->
          self.severalPlus("sent_messages").getList()
          # Restangular.severalPlus"sent_messages", self.sent_message_ids).getList()
          # Restangular.several("me/sent_messages", self.sent_message_ids).getList()


      self.receivedMessages = ->
        self.severalPlus("received_messages").getList()
          # Restangular.severalPlus(self, "received_messages", self.received_message_ids).getList()
      
      self.posts = (params)->
        # if self.post_ids.length > 0
        #   Restangular.several("me/posts", self.post_ids).getList()
        # else $q.when([])
        self.getListPlus("posts", params)
        # self.several('posts',[2,3,4]).getList()
        # Restangular.all("me/posts").getList()

      self.followers = ->
        if self.follower_ids.length > 0
          Restangular.all("me/followers").getList({entity_id: self.id, entity_type: self.type})
        else $q.when([])

      self.personalPosts = ->
        self.severalPlus("posts").getList()

        # if self.personal_post_ids.length > 0
        #   Restangular.several("me/posts", self.personal_post_ids).getList()
        # else $q.when([])

      # self.several2()

      return self
]