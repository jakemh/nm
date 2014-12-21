App.factory "SideBar", [
  "$q"
  ($q) ->
    
    delegate: {}
    rightBarTemplate: "blank.html"
    mapLoaded:  false
    tabBarVisible: true
    tabBarDisabled: false
    messageCount: 0
    
    # profExternalInit: ->
    #   delegate = SideBar.delegate
      
    tabItemClick: (entity)->
      
    showMessageCount: ->
      if @messageCount > 0
        return @messageCount 
      else return null

    eachEntityUnreadMessages: (currentUser) -> 
      currentUser.ownedEntities().then (entities) ->
        allMessagesPromises = []
        for entity in entities
          do (entity) =>
            entity.getAllMessages().then (msgs) ->
              entity.unreadMessages = _.where msgs, {unread: true}

    eachEntityUnreadMessages2: (currentUser) -> 
      currentUser.ownedEntities().then (entities) ->
        allMessagesPromises = []
        for entity in entities
          do (entity) =>
            entity.getAllMessages().then (msgs) ->
              entity.unreadMessages = []


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
