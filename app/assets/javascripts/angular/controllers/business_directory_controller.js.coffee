angular.module("NM").controller "BusinessDirectoryController", [
  "$scope"
  "Business"
  "User"
  "Restangular"
  "SideBar"
  "MapService"
  "$location"
  
  ($scope, Business, User, Restangular, SideBar, MapService, $location) ->
    
    $scope.SideBar = SideBar
    SideBar.rightBarTemplate = "right_bar_business.html"        
    $scope.businesses = []
    $scope.businessList = []
    $scope.SideBar = SideBar
    $scope.mapLoaded = false
    $scope.peopleList = []
    # $scope.displayList = $scope.businessList.concat($scope.peopleList)
    $scope.query = null
    $scope.mapObj = null
    # $scope.rightBarTemplate = "right_bar_business.html"        
    SideBar.rightBarTemplate = "right_bar_business.html"        
    
    # $scope.loadMap()
    SideBar.tabBarVisible = false 

    $scope.init = ->
    

    # $scope.addMarker = (marker)->
    #   $scope.mapObj.addMarker(marker)
    

    # $scope.$watch "SideBar.mapLoaded", ->
    #   if SideBar.mapLoaded == true
    #     $scope.mapObj = new GMaps
    #       div: '#map'
    #       lat: 35
    #       lng: -122
    #       zoom: 2
    #     $scope.mapLoaded = true
    #   SideBar.mapLoaded = false

    $scope.searching = false
    $scope.personFilter = false
    $scope.businessFilter = true
    $scope.engine = new Bloodhound(
         name: "businessSearch"
         remote:
           url: "/search?q=%QUERY"

         datumTokenizer: (d) ->
           d

         queryTokenizer: (d) ->
           d
       )
    
    $scope.$watch "businesses + displayList", ->
      busCoords = MapService.mapToMarker($scope.businesses)
      displayCoords = MapService.mapToMarker($scope.displayList)
      markerArray = []
      markerArray = markerArray.concat(busCoords)
      markerArray = markerArray.concat(displayCoords)
      for marker in markerArray
        MapService.map.addMarker(marker)

    $scope.$watch "query", ->
      if $scope.query
        $scope.submit()

    # $scope.mapToMarker = (array) ->
    #   _.map array, (item)->
    #     lat: item.latitude || null
    #     lng: item.longitude || null
    #     click: ->
    #       $scope.visitProfile(item.uri)

    # $scope.$watch "personFilter", ->
    #     User.query().then ((results) ->
    #       $scope.personList = results["users"]
    #       # alert JSON.stringify results["businesses"]
    #       $scope.searching = false
    #       return
    #     ), (error) ->

    $scope.$watch "businessFilter", ->
      # $scope.$apply()

    $scope.visitProfile = (uri)->
      # window.location.href = uri
      $location.path( uri );

    $scope.alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    $scope.alphabet.split()
    $scope.letterClick = (letter) -> 
        # Entity.query({first_letter: letter}, null, null).then ((results) ->
        #   $scope.displayList = results["entities"]
        #   # alert JSON.stringify results["businesses"]
        #   $scope.searching = false
        #   return
        # ), (error) ->
        Restangular.all("entities").getList({first_letter: letter}).then (entities)->
          $scope.displayList = entities
      
             # $scope.businessList = 
    $scope.randomClick = (bus)->
      # alert JSON.stringify bus
      $location.path( bus.uri );

      # window.location.href = bus.uri
    $scope.engine.initialize()
    # Business.query().then ((results) ->
    #   $scope.businesses = results["businesses"]
    #   # alert JSON.stringify results["businesses"]
    #   $scope.searching = false
    #   return
    # ), (error) ->
      
    #   $scope.searching = false
   
    Restangular.all("businesses").getList().then (businesses)->
      $scope.businesses = businesses


    $scope.submit = () ->
      $scope.engine.get $scope.query, (suggestions) ->
        $scope.displayList = suggestions[0]
        # alert JSON.stringify $scope.businessList
        $scope.$apply()
#
    #
     #Find a single book and update it
    #Book.get(1234).then (book) ->
      #book.lastViewed = new Date()
      #book.update()
      #return
#
    #
     # Create a book and save it
    #new Book(
      #title: "Gardens of the Moon"
      #author: "Steven Erikson"
      #isbn: "0-553-81957-7"
    #).create()
]

angular.module("NM").filter "entityFilter", ->
  (entities, personFilter, businessFilter) ->
    if entities
      entities.filter (entity) ->
        return personFilter if entity.type == "User"
        return businessFilter if entity.type == "Business"