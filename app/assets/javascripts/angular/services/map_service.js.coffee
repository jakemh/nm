App.factory "MapService", [
  "$q"
  "$compile"
  "$rootScope"
  ($q, $compile, $rootScope) ->
    mapObj: null
  
    onMapDivLoad: (elem)->
      @init(elem)

    initAfter: ->
    coordsArray: []

    init: (elem)->
      # @clear()

      if !@mapObj
        @mapObj = new GMaps
          div: $(".map")[0]
          lat: 35
          lng: -122
          zoom: 2
          # maxZoom: 15
        $(".map").removeClass("empty-map")

      else 
        mapNode = @mapObj.getDiv()
        divs = $(".map")
        if mapNode != divs
          newDiv = null
          if divs.length > 1
            # div = divs[divs.length - 1]
            for div in divs
              jDiv = $(div)
              if jDiv.hasClass("empty-map")
                newDiv = jDiv
                jDiv.removeClass("empty-map")
            # debugger
            # div.replaceWith($(divs[0]));
          else 
            newDiv = divs

          newDiv.replaceWith($(mapNode));
          

      if @coordsArray.length > 0
        @resetMap(@coordsArray)
        
    add: (marker)->
      if @mapObj
        @mapObj.addMarker(marker)
      else 
        @init()
        @add(marker)

    

    mapToMarker: (array) ->

      text = (item) -> "
            <div ng-click=\"visitProfile('#{item.link()}')\" class=\"map__card\"> 
              <div data-fittext=\"2\" class=\"map__title\">#{item.name}</div>
               
                <div class=\"map__thumb thumb--100\">
                  <img src=\"#{item.thumb}\">
                </div>
            <div>
          "

      returnArray = _.map array, (item)->
        lat: item.latitude || null
        lng: item.longitude || null
        infoWindow: {
          # content: "<div ng-include=\"'map.html'\"></div>"

          content: $compile(text(item))($rootScope)[0]
        }
        click: ->
          # $scope.visitProfile(item.uri)
      
      return returnArray

    clearCoordsArray: ->
      if @coordsArray.length > 0
        while @coordsArray.length > 0
          @coordsArray.pop()

    clearMap: ->
      if @mapObj
        @mapObj.removeMarkers()

    resetMap: (markerArray, clearCoordsArray)->
      @clearCoordsArray() if clearCoordsArray
      @clearMap()
      
      for marker in markerArray
        if marker.lat && marker.lng
          @mapObj.addMarker(marker)

      @mapObj.setOptions({ maxZoom: 15 });
      @mapObj.refresh()

      @mapObj.fitZoom()
      # @mapObj.setOptions({ maxZoom: null });


]
