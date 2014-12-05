App.factory "MapService", [
  "$q"
  ($q) ->
    mapObj: null
  
    onMapDivLoad: (elem)->
      @init(elem)

    initAfter: ->

    init: (elem)->
      @mapObj = new GMaps
        div: elem || '#map'
        lat: 35
        lng: -122
        zoom: 2

    initBusDir: ->
      debugger
      @mapObj = new GMaps
        div: '#map-bus-dir'
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
        
        if marker.lat && marker.lng
          @mapObj.addMarker(marker)
]
