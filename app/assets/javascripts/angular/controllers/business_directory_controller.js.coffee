angular.module("NM").controller "BusinessDirectoryController", [
  "$scope"
  "Business"
  "User"
  "Restangular"
  "SideBar"
  "MapService"
  "$location"
  "$filter"
  
  ($scope, Business, User, Restangular, SideBar, MapService, $location, $filter) ->
    
    $scope.SideBar = SideBar
    # SideBar.rightBarTemplate = "right_bar_bus_dir.html"     
    SideBar.rightBarTemplate = "blank.html"        
   
    $scope.businesses = []
    $scope.businessList = []
    $scope.SideBar = SideBar
    $scope.mapLoaded = false
    $scope.peopleList = []
    $scope.displayList = []
    # $scope.displayList = $scope.businessList.concat($scope.peopleList)
    $scope.query = null
    $scope.mapObj = null
    # $scope.rightBarTemplate = "right_bar_business.html"        
    # SideBar.rightBarTemplate = "right_bar_bus_dir.html"        
    $scope.MapService = MapService
    # $scope.loadMap()  
    SideBar.tabBarVisible = false 

    $scope.applyMarkers = ->
      addMarkers = $filter('entityFilter')($scope.displayList, $scope.filters.person, $scope.filters.business);
      hasMarkers = false

      if MapService.mapObj && addMarkers.length > 0
        hasMarkers = true 
        setTimeout ->
          MapService.mapObj.refresh()
          MapService.resetMap(MapService.mapToMarker(addMarkers), true)
        , 1
      else 
        hasMarkers = false 

      return hasMarkers

    $scope.init = ->
      Restangular.all("businesses").getList({random: true}).then (businesses)=>
        $scope.businesses = businesses
    # $scope.personFilter = false
    # $scope.businessFilter = true

    $scope.filters = 
      person: false
      business: true

    $scope.$watch "filters", ->
      $scope.applyMarkers()
    , true

    $scope.setMarkerArray = ->
      busCoords = MapService.mapToMarker($scope.businesses)
      # displayCoords = MapService.mapToMarker($scope.displayList)
      markerArray = []
      markerArray = markerArray.concat(busCoords)
      # markerArray = markerArray.concat(displayCoords)
      # MapService.resetMap(markerArray) 

    $scope.engine = new Bloodhound(
         name: "businessSearch"
         remote:
           url: "/search?q=%QUERY"

         datumTokenizer: (d) ->
           d

         queryTokenizer: (d) ->
           d
       )
    $scope.engine.initialize()

    # $scope.$watch "businesses + displayList", ->


    $scope.$watch "query", ->
      if $scope.query
        $scope.submit()

   

    $scope.$watch "businessFilter", ->
      # $scope.$apply()

    $scope.visitProfile = (uri)->
      # window.location.href = uri
      $location.path( uri );

    $scope.alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    $scope.alphabet.split()
    
    $scope.letterClick = (letter) -> 
      Restangular.all("entities").getList({first_letter: letter}).then (entities)->
        $scope.displayList = entities
        $scope.applyMarkers()

    $scope.randomClick = (bus)->
      $location.path( bus.uri );

  
  

      # MapService.resetMap(MapService.mapToMarker($scope.businesses))

    $scope.submit = () ->
      $scope.engine.get $scope.query, (suggestions) ->
        $scope.displayList = suggestions[0]
        # MapService.resetMap(MapService.mapToMarker($scope.displayList))
        $scope.applyMarkers()
        $scope.$apply()
]

angular.module("NM").filter "entityFilter", ->
  (entities, personFilter, businessFilter) ->
    if entities
      entities.filter (entity) ->
        return personFilter if entity.type == "User"
        return businessFilter if entity.type == "Business"

angular.module("NM").filter "currentEntityFilter", ->
  (displayMessages, currentEntity) ->
    if displayMessages
      displayMessages.filter (msg) ->
        if msg.models.post.type == "ReceivedMessage"
          return msg.models.post.to_entity_id == currentEntity.id &&
            msg.models.post.to_entity_type == currentEntity.type
        else return true

        