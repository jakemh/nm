angular.module("NM").factory "User", [

  "$q"
  "Restangular"
  "RestangularPlus"
  "RestEntity"

  ($q, Restangular, RestangularPlus, RestEntity) ->
    Restangular.extendModel "users", (self) =>
      angular.extend self, RestangularPlus
      angular.extend self, angular.copy(RestEntity)
      
      self.link = ->
        return "users/#{self.id}"

      self.isUser = () ->
        true
        

      self.ownedEntities = ->
        deferred = $q.defer();
        returnList = [self]
        self.businesses().then (businesses)->
          
          for business in businesses
            returnList.push(business)
            
          deferred.resolve(returnList)

        return deferred.promise

      self.associatedEntities = ->
        return self.businesses()

      self.businesses = ->
        # self.getListPlus("businesses")
        
        self.severalPlus("businesses", self.business_ids)

      
      self.isFollowedBy = (userEntity) ->
        if _.contains(userEntity.user_connection_ids, self.id)
          return true 
        else return false
      
      self.canBeFollowedBy = (userEntity) ->
        if self == userEntity
          return false #same entity

        if userEntity.type == "User"
          return true #users can follow any user but themselves
        else if userEntity.type == "Business"
          return false #business cannot follow user

      return self
]