App.factory "SideBar", [
  () ->
 
    rightBarTemplate: "blank.html"
    mapLoaded:  false
    tabBarVisible: true
    onMapLoad: ->
      @mapLoaded = true
      # @mapLoaded = false
      # callback()
]
