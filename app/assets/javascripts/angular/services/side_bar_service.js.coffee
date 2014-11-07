App.factory "SideBar", [
  () ->
 
    rightBarTemplate: "blank.html"
    mapLoaded:  false
    onMapLoad: ->
      @mapLoaded = true
      # @mapLoaded = false
      # callback()
]
