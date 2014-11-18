App.factory "MapService", [
  "$q"
  ($q) ->
    mapObj: null
  
    onMapDivLoad: ->
      @init()

    initAfter: ->

    init: ->
      @mapObj = new GMaps
        div: '#map'
        lat: 35
        lng: -122
        zoom: 2
  
    add: (marker)->
      if @mapObj
        @mapObj.addMarker(marker)
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
      if @mapObj
        @mapObj.removeMarkers()
      else 
        @init()
        @clear()

    resetMap: (markerArray)->
      @clear()
      for marker in markerArray
        @mapObj.addMarker(marker)
]
