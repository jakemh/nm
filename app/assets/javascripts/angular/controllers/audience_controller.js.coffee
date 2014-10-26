angular.module("NM").controller "AudienceController", [
  "$scope"
  "$sce"
  "Utilities"
  "Follower"
  "User"
  "Business"
  "Entity"
  "AuthService"
  ($scope, $sce, Utilities, Follower, User, Business, Entity, AuthService) ->
    $scope.Utilities = Utilities
    $scope.feedContentPartial = "feed_body_audience.html"
    $scope.AuthService = AuthService
    $scope.audMemberClass = (index)->
      if index % 2 == 0
        return "aud__member--left" 
      else return "aud__member--right"

    # $scope.trustAsHtml = (value) -> 
    #   return $sce.trustAsHtml(value);
      
    

    $scope.$watch 'AuthService.userBusinesses', ->
      if AuthService.currentUser
        # $scope.entityOptions = _.map [$scope.currentUser].concat($scope.userBusinesses), (item, i) ->
        #   name: item.name
        #   thumb: item.thumb
        #   id: i
        AuthService.entityOptions = [AuthService.currentUser].concat(AuthService.userBusinesses)
        AuthService.currentEntitySelection.selected = AuthService.entityOptions[0]

    # $scope.followers = []
    # $scope.currentUser = null
    # $scope.userBusinesses = null
    # $scope.currentEntitySelection = {}
    # $scope.entityOptions = null
    $scope.displayList = []
    $scope.sortOptions = [
      {name: "added", id: 1}
      {name: "distance", id: 2}
      {name: "name", id: 3}

    ]
 
    $scope.filterOptions = [
      {name: "Show All", id: 0, group: "Main"}
      {name: "Businesses Only", id: 1, group: "Main"}
      {name: "Industry1", id: 2, group: "Industry"}
      {name: "Industry2", id: 2, group: "Industry"}
      {name: "Industry3", id: 2, group: "Industry"}
      {name: "Industry4", id: 2, group: "Industry"}

      {name: "Type1", id: 3, group: "Type"}
      {name: "Type2", id: 3, group: "Type"}
      {name: "Type3", id: 3, group: "Type"}
      {name: "Type4", id: 3, group: "Type"}
    ]

    $scope.filterGroup = (item)->
      return item.group

    # $scope.sortVal = $scope.sortOptions[0]
    $scope.sortVal = {}
    $scope.filterVal = {}
    $scope.filterVal.selected = $scope.filterOptions[0]

    $scope.$watch 'AuthService.currentFollowers', ->
      if AuthService.currentFollowers.length > 0
        $scope.displayList = _.map  AuthService.currentFollowers, (item)-> 
          # alert JSON.stringify item
          name: item.entity().name
          distance: item.entity().distance
          added: item.createdAt
          thumb: item.entity().thumb
          profile: item.entity().uri
          type: item.type
          entityType: item.entity().type

    # $scope.watch 'currentEntitySelection', ->

]
App.filter "slice", ->
  (arr, start, end) ->
    (arr or []).slice start, end


angular.module("NM").filter "audienceFilter", ->
  (entities, filterVal) ->
    if entities
      entities.filter (entity) ->

        if filterVal

          if filterVal.name == "Businesses Only"
            # alert JSON.stringify entity
            return false if entity.entityType != "Business"
            return true
        return true
      # entities.filter (entity) ->
      #   return personFilter if entity.type == "User"
      #   return businessFilter if entity.type == "Business"
