App.factory "MapService", [

  () ->
    map: null

    onMapDivLoad: ->
      @init()

    initAfter: ->

    init: ->
      @map = new GMaps
        div: '#map'
        lat: 35
        lng: -122
        zoom: 2
      $scope.mapLoaded = true
  
    add: (marker)->
      if @map
        @map.addMarker(marker)
      else 
        @init()
        @add(marker)
        
    mapToMarker: (array) ->
      _.map array, (item)->
        lat: item.latitude || null
        lng: item.longitude || null
        click: ->
          # $scope.visitProfile(item.uri)

    clear: ->
      if @map
        @map.removeMarkers()
      else 
        @init()
        @clear()
]
