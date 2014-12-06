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
      
    $scope.audMemberClass = (index)->
      console.log "INDEX: " + index
      if index % 2 == 0
        return "aud__member--left" 
      else return "aud__member--right"

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
        # $q.all(AuthService.currentFollowers)
        $scope.displayList = []
        for f in AuthService.currentFollowers
          do (f) -> 
            f.entity().then (e) ->
              entity = e
              # alert JSON.stringify entity
              $scope.displayList.push
                models: {entity: entity}
                name: entity.name
                distance: entity.distance
                added: f.created_at
                thumb: entity.thumb
                profile: entity.uri
                type: f.type
                entityType: entity.type
            


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
