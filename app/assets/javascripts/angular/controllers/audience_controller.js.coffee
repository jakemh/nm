angular.module("NM").controller "AudienceController", [
  "$scope"
  "$q"
  "Utilities"
  "Restangular"
  "AuthService"
  "SideBar"
  ($scope, $q, Utilities, Restangular, AuthService, SideBar) ->
    $scope.Utilities = Utilities
    $scope.feedContentPartial = "feed_body_audience.html"
    $scope.AuthService = AuthService
    $scope.SideBar = SideBar
    $scope.followersList = []
    $scope.followingList = []

    $scope.followersDisplay = []
    $scope.followingDisplay = []

    $scope.displayList = []
    # SideBar.rightBarTemplate = "right_bar_business.html"        
    SideBar.rightBarTemplate = "blank.html"  

    # $scope.loadMap()
    SideBar.tabBarVisible = true 
    # $scope.$watch "SideBar.mapLoaded", ->
    #   if SideBar.mapLoaded == true
    #     $scope.mapObj = new GMaps
    #       div: '#map'
    #       lat: 35
    #       lng: -122
    #       zoom: 2
    #     $scope.mapLoaded = true
    #   SideBar.mapLoaded = false
    
    $scope.followerFilter = true
    $scope.followingFilter = false

    $scope.$watch "AuthService.currentEntitySelection.selected", ->
      # console.log AuthService.currentEntitySelection.selected.follower_ids
      while $scope.followingList.length > 0 || 
          $scope.followersList.length > 0 ||
          $scope.followersDisplay.length > 0 ||
          $scope.followingDisplay.length > 0

        $scope.followingList.pop()
        $scope.followersList.pop()
        $scope.followersDisplay.pop()
        $scope.followingDisplay.pop()

      ent = AuthService.currentEntitySelection.selected
      $scope.getFollowing(ent)
      $scope.getFollowers(ent)

    $scope.init = () ->
      ent = AuthService.currentEntitySelection.selected

      # $scope.getFollowing(ent)
      # $scope.getFollowers(ent)

    $scope.getFollowers = (ent)->
      ent.followers().then (followers)->
        $scope.followersList = followers

    $scope.getFollowing = (ent)->
      ent.following().then (following)->
        $scope.followingList = following

    $scope.audMemberClass = (index)->
      console.log "INDEX: " + index
      if index % 2 == 0
        return "aud__member--left" 
      else return "aud__member--right"

    
      # $scope.followersDisplayList.concat($scope.followingDisplayList)

    # $scope.$watch 'followerDisplay + followingDisplay', ->
    #   $scope.displayList = $scope.followersDisplay.concat($scope.followingDisplay)

    $scope.sortOptions = [
      {name: "added", id: 1}
      {name: "distance", id: 2}
      {name: "name", id: 3}

    ]
 
    $scope.filterOptions = [
      {name: "Show All", id: 0, group: "Main"}
      {name: "Businesses Only", id: 1, group: "Main"}
      # {name: "Industry1", id: 2, group: "Industry"}
      # {name: "Industry2", id: 2, group: "Industry"}
      # {name: "Industry3", id: 2, group: "Industry"}
      # {name: "Industry4", id: 2, group: "Industry"}

      # {name: "Type1", id: 3, group: "Type"}
      # {name: "Type2", id: 3, group: "Type"}
      # {name: "Type3", id: 3, group: "Type"}
      # {name: "Type4", id: 3, group: "Type"}
    ]

    $scope.filterGroup = (item)->
      return item.group

    # $scope.sortVal = $scope.sortOptions[0]
    $scope.sortVal = {}
    $scope.filterVal = {}
    $scope.filterVal.selected = $scope.filterOptions[0]

    $scope.$watch 'followersList', ->
        # $q.all(AuthService.currentFollowers)
        $scope.followersDisplayList = []
        for f in $scope.followersList
          do (f) -> 
            f.entity().then (e) ->
              entity = e
              # alert JSON.stringify entity

              $scope.followersDisplay.push
                models: {entity: entity, connection: f}
                name: entity.name
                distance: entity.distance
                added: f.created_at
                thumb: entity.thumb
                profile: entity.uri
                type: f.type
                entityType: entity.type
    
    $scope.$watch 'followingList', ->
        # $q.all(AuthService.currentFollowers)
        $scope.followingDisplay = []
        
        for f in $scope.followingList
          do (f) -> 
            f.entity().then (e) ->
              entity = e


              # alert JSON.stringify entity
              $scope.followingDisplay.push
                models: {entity: entity, connection: f}
                name: entity.name
                distance: entity.distance
                added: f.created_at
                thumb: entity.thumb
                profile: entity.uri
                type: f.type
                entityType: entity.type
            


]
angular.module("NM").filter "audienceTypeFilter", ->
  (displayEntities, currentEntity, followerFilter, followingFilter) ->
    if displayEntities
      displayEntities.filter (displayEntity) ->
        connection = displayEntity.models.connection
        if followerFilter
          bool =  _.contains currentEntity.follower_ids, connection.id
          return true if bool
        if followingFilter
          # console.log ["FOLLOWING", bool, connection.id, JSON.stringify currentEntity.following_ids]

          return true if _.contains currentEntity.following_ids, connection.id

        return false

App.filter "slice", ->
  (arr, start, end) ->
    (arr or []).slice start, end


angular.module("NM").filter "userBusinessFilter", ->
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
