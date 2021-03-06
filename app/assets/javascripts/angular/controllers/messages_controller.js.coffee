class MessageEntity
  constructor: (@entity) ->
    @messages = []
    @unreadMessages = []
    @displayMessages = []

  addMessage: (msg) ->
    @messages.push(msg)

  lastMessage: () ->
    # _.sortBy @messages, (m) -> m.id
    @messages[@messages.length - 1]

  lastDisplayMessage: () ->
    # _.sortBy @messages, (m) -> m.id
    @displayMessages[@displayMessages.length - 1]
    
angular.module("NM").controller "MessagesController", [
  "$scope"
  "$q"
  "Utilities"
  "AuthService"
  "MessagesDisplay"
  "Restangular"
  "SideBar"
  "MessageService"
  "RestangularPlus"
  "UsersCache"
  "entityHash"
  "$filter"
  "$location"

  ($scope, $q,  Utilities, AuthService, MessagesDisplay, Restangular, SideBar, MessageService, RestangularPlus, UsersCache, entityHash, $filter, $location) ->
    # $scope.messages = []
    $scope.current = AuthService.currentEntitySelection.selected
    $scope.entityHash = entityHash
    $scope.displayEnt = () ->
      entityHash(AuthService.currentEntitySelection.selected)

    # $scope.sentMessages = []
    # $scope.receivedMessage = []
    # $scope.sentMessagesDisplay = []
    # $scope.receivedMessagesDisplay = []
    $scope.searching = []
    $scope.AuthService = AuthService
    $scope.Utilities = Utilities
    $scope.displayMessages = []
    $scope.newMessage = {}
    SideBar.tabBarVisible = true 
    $scope.displayEntities = null
    # $scope.userList = []
    # $scope.unreadList = []
    # $scope.entityList = []
    # $scope.allMessages = []
    # $scope.feedHeadBody = "feed_head_form.html"
    $scope.entitiesLoaded = false
    $scope.feedCornerPartial = "feed_body_comment.html"
    $scope.SideBar = SideBar
    SideBar.rightBarTemplate = "blank.html"  

    $scope.messageObject = (newPost) ->
      object = angular.copy(newPost)
      $scope.delegate.newPost = {}
      return object
    # $scope.headOuterInit = (newPost, entity) ->
    #   newPost.type = ''

    $scope.randomProfile = ->
      Restangular.all("businesses").getList({random: true}).then (businesses)=>
        $location.path(businesses[0].link());

    $scope.submitHandler = ->
      MessageService.submit(newPost, entity, entryForm, sendPost)
      
    $scope.markAsRead = (msg)->
      currentEntity = AuthService.currentEntitySelection.selected
      msg.models.post.unread = false
      msg.models.post.put().then () ->
        SideBar.allUnreadMessages(AuthService.currentUser).then (list) ->
          SideBar.messageCount = list.length
        SideBar.eachEntityUnreadMessages(AuthService.currentUser)

      # currentEntity.one('received_messages', msg.id).get(read: true).then (newMsg)->
      #   MessageService.loadUnreadMessages(currentEntity).then (msgs)->
      #     MessageService.buildEntityUnreadList($scope.entityList, msgs, currentEntity)
      #     $scope.MessageService.unreadList = msgs
      #     $scope.MessageService.buildUserEntityUnreadList(msgs, AuthService.entityOptions)
      #   msg.models.post.unread = false    

    $scope.unread = (msg)->
      msg.models.post.unread
      # $scope.allMessages = $scope.sentMessages.concat $scope.receivedMessages
    
    $scope.unreadQuantity = (entity)->
      unreadList =  _.where entity.messages, {type: "ReceivedMessage", unread:  true}
      l = unreadList.length
      if l > 0 
        return  l

    $scope.getSentMessages = (entity)->
      entity.getSentMessages()

    $scope.getReceivedMessages = (entity)->
      entity.getReceivedMessages()

    $scope.getAllMessages = (entity) ->
      deferred = $q.defer();

      $q.all([$scope.getReceivedMessages(entity), $scope.getSentMessages(entity)]).then (all) ->
        # alert JSON.stringify all
        allMessages = []

        for array in all
          allMessages = allMessages.concat array

        deferred.resolve(allMessages)
      return deferred.promise


        # alert Utilities.entityCompare()
    $scope.sentMessageInit = (newPost)->
      newPost.type = "SentMessage"

    $scope.selectEntity = (displayEntity)->
      $scope.selectedEntity = displayEntity
      # $scope.getAllMessages($scope.selectedEntity).then (all)->
      #   $scope.allMessages = all

    $scope.receivedMessageInit = (newPost)->
      newPost.type = "ReceivedMessage"

    $scope.messageCallback = (response) ->
      #set sidebar count
      SideBar.eachEntityUnreadMessages(AuthService.currentUser)

      SideBar.allUnreadMessages(AuthService.currentUser).then (list) ->
        SideBar.messageCount = list.length
      # $scope.getAllMessages(AuthService.currentEntitySelection.selected).then (all)->
      selectedEntity.addSentMessageId(response.id)
      response.toEntity().then (toEntity) ->
        ownedEntity = entityHash(toEntity)
        if ownedEntity
          ownedEntity.entity.addReceivedMessageId(response.id)

        $scope.selectedEntity.addMessage(response)
        # $scope.selectedEntity.addMessage(response)
        $scope.buildMessages(selectedEntity).then () ->
          list = _.sortBy $scope.displayEnt().getEntitiesList(), (item) -> item.lastMessage().id
          $scope.selectedEntity = list[list.length - 1]


    $scope.sendPost = (postSubmit)->
      
      selectedEntity = AuthService.currentEntitySelection.selected
      entityAttrs = 
        from_id: selectedEntity.id
        from_type: selectedEntity.type
        to_id: $scope.selectedEntity.entity.id
        to_type: $scope.selectedEntity.entity.type
        type: "Message"

      postSubmit = angular.extend({}, postSubmit, entityAttrs)


      # route = selectedEntity.message_route
      # alert JSON.stringify postSubmit
      selectedEntity.post('messages', postSubmit).then (response)->

        #set sidebar count
        SideBar.eachEntityUnreadMessages(AuthService.currentUser)

        SideBar.allUnreadMessages(AuthService.currentUser).then (list) ->
          SideBar.messageCount = list.length
        # $scope.getAllMessages(AuthService.currentEntitySelection.selected).then (all)->
        selectedEntity.addSentMessageId(response.id)
        response.toEntity().then (toEntity) ->
          ownedEntity = entityHash(toEntity)
          if ownedEntity
            ownedEntity.entity.addReceivedMessageId(response.id)

          $scope.selectedEntity.addMessage(response)
          # $scope.selectedEntity.addMessage(response)
          $scope.buildMessages(selectedEntity).then () ->
            list = _.sortBy $scope.displayEnt().getEntitiesList(), (item) -> item.lastMessage().id
            $scope.selectedEntity = list[list.length - 1]
            # $scope.selectedEntity = $scope.displayEnt().getEntitiesList()[0]

        # MessagesDisplay.buildMessageDisplay2($scope.selectedEntity.displayMessages, $scope.selectedEntity.messages, {suppressResponses: true})

        # $scope.selectedEntity.addReceivedMessage(response.id)
        # $scope.buildMessages(selectedEntity).then () ->


        # $scope.posts = $scope.posts.concat(response)
          # console.log "POSTS: " + JSON.stringify posts

    $scope.buildMessages = (currentEntity)->
      deferred = $q.defer();

      $scope.getAllMessages(currentEntity).then (all)->
        # $scope.allMessages = all
        all = _.sortBy all, (m) -> m.id

        $scope.displayEnt().allMessages = all
        $q.all($scope.displayEnt().buildEntitiesList()).then (entities) ->
          # debugger\
          $scope.displayEnt().entitiesList = []
          # console.log entities
      
          for entity in _.uniq entities
            displaySubEnt = new MessageEntity(entity)
            $scope.displayEnt().entitiesList.push(displaySubEnt)
            MessageService.buildEntityMessageList(displaySubEnt, $scope.displayEnt().allMessages)
            MessagesDisplay.buildMessageDisplay2(displaySubEnt.displayMessages, displaySubEnt.messages, {suppressResponses: true})

          deferred.resolve(true)

      return deferred.promise
    
    $scope.$watch 'AuthService.currentEntitySelection.selected', ->
      $scope.entitiesLoaded = false

      currentEntity = AuthService.currentEntitySelection.selected
      $scope.buildMessages(currentEntity).then () ->
        $scope.entitiesLoaded = true
        list = _.sortBy $scope.displayEnt().getEntitiesList(), (item) -> item.lastMessage().id
        $scope.selectedEntity = list[list.length - 1]
    
    $scope.delegate = 
      newPost: {}
      validationHandler: MessageService.submitHandler
      submitHandler: $scope.sendPost
      messageObject: $scope.messageObject
      
]