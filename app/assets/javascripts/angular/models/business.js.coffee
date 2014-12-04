angular.module("NM").factory "Business", [
  "$q"
  "Restangular"
  "RestangularPlus"
  "RestEntity"
  ($q, Restangular, RestangularPlus, RestEntity) ->
    Restangular.extendModel "businesses", (self) ->
      angular.extend self, RestangularPlus
      angular.extend self, RestEntity

      self.owner = ->
        Restangular.one("users", self.owner_id).get()
      

      self.ownedUnreadMessages = []

      self.reviews = ->
        self.getListPlus("reviews")

      # self.getItems = ->
      #   self.getListPlus("items")
      
      self.review = (params) ->
        @post('reviews', {score: params.score, content: params.content})

      self.ownedUnreadMessages = []
      self.items = []
      self.unreadMessages = []

      # self.items = []
      return self
]