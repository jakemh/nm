App.factory "MapService", [
  "$q"
  ($q) ->
    mapObj: null
  
    onMapDivLoad: (elem)->
      @init(elem)

    initAfter: ->
    coordsArray: []

    init: (elem)->
      # @clear()
      @mapObj = new GMaps
        div: elem || '#map'
        lat: 35
        lng: -122
        zoom: 2
        # maxZoom: 15

      
      if @coordsArray.length > 0
        @resetMap(@coordsArray)
        
    initBusDir: ->
      @mapObj = new GMaps
        div: '#map-bus-dir'
        lat: 35
        lng: -122
        zoom: 2

      if @coordsArray.length > 0
        @resetMap(@coordsArray, true)

    add: (marker)->
      if @mapObj
        @mapObj.addMarker(marker)
      else 
        @init()
        @add(marker)

    mapToMarker: (array) ->
      returnArray = _.map array, (item)->
        lat: item.latitude || null
        lng: item.longitude || null
        click: ->
          # $scope.visitProfile(item.uri)
      
      return returnArray

    clear: ->
      if @coordsArray.length > 0
        while @coordsArray.length > 0
          @coordsArray.pop()

      if @mapObj
        @mapObj.removeMarkers()

    resetMap: (markerArray, clear)->
      @clear() if clear

      for marker in markerArray
        if marker.lat && marker.lng
          @mapObj.addMarker(marker)

      @mapObj.setOptions({ maxZoom: 15 });
      @mapObj.refresh()

      @mapObj.fitZoom()
      # @mapObj.setOptions({ maxZoom: null });


]
