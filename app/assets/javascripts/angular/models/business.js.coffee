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

      self.link = ->
        return "businesses/#{self.id}"

      self.addReview = (review) ->
        self.review_ids.push review.id
        self.reviews.push review
        
      self.owner = ->
        RestangularPlus.getModel("users", self.owner_id)
      
      self.owners = ->
        RestangularPlus.severalPlus("users", self.owner_ids)
      
      self.associatedEntities = ->
        return self.owners()

      self.ownedUnreadMessages = []

      self.getReviews = ->
        self.getListPlus("reviews")


      self.review = (params) ->
        @post('reviews', {score: params.score, content: params.content})

      self.isFollowedBy = (userEntity) ->
        
        if _.contains(userEntity.business_connection_ids, self.id)
          return true
        else return false
      
      self.canBeFollowedBy = (userEntity) ->
        
        if self == userEntity
          return false #same entity

        return true #business can be followed by anythign but themselves


      return self
]