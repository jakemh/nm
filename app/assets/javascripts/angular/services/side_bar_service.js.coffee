App.factory "SideBar", [
  () ->
    
    delegate: {}
    rightBarTemplate: "blank.html"
    mapLoaded:  false
    tabBarVisible: true
    tabBarDisabled: false
    messageCount: 0
    
    showMessageCount: ->
      if @messageCount > 0
        return @messageCount 
      else return null

    onMapLoad: ->
      @mapLoaded = true
      # @mapLoaded = false
      # callback()
]
