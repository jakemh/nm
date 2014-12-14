App.factory "SideBar", [
  "$q"
  ($q) ->
    
    delegate: {}
    rightBarTemplate: "blank.html"
    mapLoaded:  false
    tabBarVisible: true
    tabBarDisabled: false
    messageCount: 0
    
    tabItemClick: (entity)->
      
    showMessageCount: ->
      if @messageCount > 0
        return @messageCount 
      else return null

    allUnreadMessages: (currentUser) ->
      currentUser.ownedEntities().then (entities) ->
        allMessagesPromises = []
        for entity in entities
          allMessagesPromises.push entity.getAllMessages()

        $q.all(allMessagesPromises).then (allMessageArrays) ->
          allMessages = []
          for messageArray in allMessageArrays
            allMessages = allMessages.concat messageArray

          unreadMessages = _.where allMessages, {unread: true}
          $q.when unreadMessages
          # $scope.SideBar.messageCount = unreadMessages.length
    onMapLoad: ->
      @mapLoaded = true
      # @mapLoaded = false
      # callback()
]
