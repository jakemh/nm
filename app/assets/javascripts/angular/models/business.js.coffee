angular.module("NM").factory "Business", [
  "$q"
  "Restangular"
  "RestangularPlus"
  "RestEntity"
  ($q, Restangular, RestangularPlus, RestEntity) ->
    Restangular.extendModel "businesses", (self) ->
      angular.extend self, RestangularPlus
      angular.extend self, angular.copy(RestEntity)

      self.reviews = []

      self.addReview = (review) ->
        self.review_ids.push review.id
        self.reviews.push review
        
      self.owner = ->
        Restangular.one("users", self.owner_id).get()
      
      self.ownedUnreadMessages = []

      self.getReviews = ->
        self.getListPlus("reviews")


      self.review = (params) ->
        @post('reviews', {score: params.score, content: params.content})

    
      return self
]