App.factory "SideBar", [
  () ->
    
    delegate: {}
    rightBarTemplate: "blank.html"
    mapLoaded:  false
    tabBarVisible: true
    tabBarDisabled: false
    messageCount: 0
    onMapLoad: ->
      @mapLoaded = true
      # @mapLoaded = false
      # callback()
]
