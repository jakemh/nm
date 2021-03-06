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

      #self.branches = []

      self.affiliations = () ->
        self.severalPlus2("affiliations", self.affiliation_ids)


      self.isUser = () ->
        true
      
      self.isMentor = () ->
        _.contains self.roles, "MentorRole"

      self.addAffiliation = (aff) ->
        self.affiliation_ids.push aff.id
        
      self.addAssignment = (type, params) ->
        self.post("assignments", angular.extend(roleable_type: type, params))

     # self.buildBranches = () ->
      #  self.severalPlus("branches", self.branch_ids).then (branches) ->
      #    self.branches = branches

      self.buildAffiliations = () ->
        self.severalPlus2("affiliations", self.affiliation_ids).then (affiliations) ->
          self.affiliations = affiliations

      self.addBranch = (branch) ->
        #self.branches.push(branch)
        #self.branch_ids.push(branch.id)

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
        # if 
        #   return false #same entity

        if userEntity.type == "User"
          return false if self.id == userEntity.id #same entity
          return true #users can follow any user but themselves
        else if userEntity.type == "Business"
          return false #business cannot follow user

      return self
]