angular.module("NM").controller "AudienceController", [
  "$scope"
  "$sce"
  "Follower"
  "User"
  "Business"
  "Entity"
  "AuthService"
  ($scope, $sce, Follower, User, Business, Entity, AuthService) ->
    $scope.init = () ->
      AuthService.user().then (user)->
        $scope.currentUser = user

    $scope.init()

    $scope.feedContentPartial = "feed_body_audience.html"

    $scope.audMemberClass = (index)->
      if index % 2 == 0
        return "aud__member--left" 
      else return "aud__member--right"

    $scope.trustAsHtml = (value) -> 
      return $sce.trustAsHtml(value);
      
    $scope.$watch 'currentUser', ->
      if $scope.currentUser
        $scope.userBusinesses = $scope.currentUser.businesses
        # $scope.$apply()

    $scope.$watch 'userBusinesses', ->
      if $scope.currentUser
        # $scope.entityOptions = _.map [$scope.currentUser].concat($scope.userBusinesses), (item, i) ->
        #   name: item.name
        #   thumb: item.thumb
        #   id: i
        $scope.entityOptions = [$scope.currentUser].concat($scope.userBusinesses)
        $scope.currentEntitySelection.selected = $scope.entityOptions[0]

    $scope.followers = []
    $scope.currentUser = null
    $scope.userBusinesses = null
    $scope.currentEntitySelection = {}
    $scope.entityOptions = null
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

    $scope.$watch 'followers', ->
      if $scope.followers.length > 0
        $scope.displayList = _.map $scope.followers, (item)-> 
          # alert JSON.stringify item
          name: item.entity().name
          distance: item.entity().distance
          added: item.createdAt
          thumb: item.entity().thumb
          profile: item.entity().uri
          type: item.type
          entityType: item.entity().type

    # $scope.watch 'currentEntitySelection', ->


    $scope.$watch 'currentEntitySelection.selected', ->
      ent = $scope.currentEntitySelection.selected
      if ent
        Follower.query({
            distance: true,
            entity_type: ent.type, 
            entity_id: ent.id
          }).then ((results) ->
            $scope.followers = results
            # alert JSON.stringify $scope.followers
            # $scope.watch "users + business"
            $scope.searching = false
            return
          ), (error) ->
            
            $scope.searching = false


    
    
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
