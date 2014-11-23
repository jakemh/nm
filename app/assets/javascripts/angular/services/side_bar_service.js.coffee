App.factory "SideBar", [
  () ->
    
    delegate: {}
    rightBarTemplate: "blank.html"
    mapLoaded:  false
    tabBarVisible: true
    tabBarDisabled: false
    onMapLoad: ->
      @mapLoaded = true
      # @mapLoaded = false
      # callback()
]
