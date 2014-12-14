class MessageEntity
  constructor: (@entity) ->
    @messages = []
    @unreadMessages = []
    @displayMessages = []

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
  ($scope, $q,  Utilities, AuthService, MessagesDisplay, Restangular, SideBar, MessageService, RestangularPlus, UsersCache, entityHash) ->
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
    # $scope.userList = []
    # $scope.unreadList = []
    # $scope.entityList = []
    # $scope.allMessages = []
    # $scope.feedHeadBody = "feed_head_form.html"
    $scope.selectedEntity = null

    $scope.feedCornerPartial = "feed_body_comment.html"
    $scope.SideBar = SideBar
    SideBar.rightBarTemplate = "blank.html"  
  

    # $scope.headOuterInit = (newPost, entity) ->
    #   newPost.type = ''
    $scope.init = ->
      # $scope.buildUserList()

      
      currentEntity = AuthService.currentEntitySelection.selected
      # $scope.getAllMessages(currentEntity).then (all)->
      #   $scope.allMessages = all
        
      # $scope.entityList().then (entities)->
      #   $scope.entityList = entities
      #   $scope.selectedEntity = entities[0]
        # MessageService.loadUnreadMessages(currentEntity).then (msgs)->
        #   MessageService.buildEntityUnreadList($scope.entityList, msgs, currentEntity) 
        
        # $scope.getAllMessages($scope.selectedEntity).then (all)->
        #   $scope.allMessages = all
          
        # $scope.loadUnreadMessages($scope.entityList)

      # $scope.entityList()
    
    $scope.markAsRead = (msg)->
      currentEntity = AuthService.currentEntitySelection.selected

      currentEntity.one('received_messages', msg.id).get(read: true).then (newMsg)->
        MessageService.loadUnreadMessages(currentEntity).then (msgs)->
          MessageService.buildEntityUnreadList($scope.entityList, msgs, currentEntity)
          $scope.MessageService.unreadList = msgs
          $scope.MessageService.buildUserEntityUnreadList(msgs, AuthService.entityOptions)
        msg.models.post.unread = false    

    $scope.unread = (msg)->
      msg.models.post.unread
      # $scope.allMessages = $scope.sentMessages.concat $scope.receivedMessages
    
    $scope.unreadQuantity = (entity)->

      unreadList =  _.where entity.messages, {type: "ReceivedMessage", unread:  true}

      return unreadList.length
      # l = entity.messages.
      # if l > 0 
      #   return  l

    # $scope.loadUnreadMessages = (entities)->
    #   AuthService.currentUser.receivedMessages(unread: true).then (msgs)->
    #     currentEntity = AuthService.currentEntitySelection.selected
    #     $scope.unreadList = msgs
    #     $scope.SideBar.messageCount = $scope.unreadList.length
    #     for e in entities
    #       e.unreadMessages = []
         

    #     for msg in msgs
    #       entity = _.find entities, (ent) -> 
    #         # debugger
    #         ent.id == msg.entity_id && 
    #         ent.type == msg.entity_type &&
    #         (msg.to_entity_id == currentEntity.id &&
    #         msg.to_entity_type == currentEntity.type)

    #       if entity
    #         entity.unreadMessages.push(msg)

    $scope.getSentMessages = (entity)->
      entity.sentMessages()

    $scope.getReceivedMessages = (entity)->
      entity.receivedMessages()

    $scope.getAllMessages = (entity) ->
      # $scope.getSentMessages()
      # $scope.getReceivedMessages()
      # deferred = $q.defer();

      # $q.all([$scope.getReceivedMessages(entity), $scope.getSentMessages(entity)]).then (all) ->
      #   # alert JSON.stringify all
      #   allMessages = []

      #   for array in all
      #     allMessages = allMessages.concat array

      #   deferred.resolve(allMessages)
      # return deferred.promise

      deferred = $q.defer();

      $q.all([$scope.getReceivedMessages(entity), $scope.getSentMessages(entity)]).then (all) ->
        # alert JSON.stringify all
        allMessages = []

        for array in all
          allMessages = allMessages.concat array

        deferred.resolve(allMessages)
      return deferred.promise


    # $scope.entityList = ->
    #   deferred = $q.defer();
    #   $q.all([$scope.userList(), $scope.businessList()]).then (all)->
    #     entityArray = [] 
    #     for array in all

    #       entityArray = entityArray.concat array
        
    #     deferred.resolve(entityArray)

    #   return deferred.promise


    # $scope.userList = ->
    #   # deferred = $q.defer();
    #   return RestangularPlus.getListPlus2("users")
    #   # Restangular.all('users').getList().then (users) ->
    #   #   # $scope.userList = users
    #   #   deferred.resolve(users)

    #   # return deferred.promise

    #     # $scope.selectedEntity = users[0]

    # $scope.businessList = ->
    #   # deferred = $q.defer();

    #   # Restangular.all('businesses').getList().then (businesses) ->
    #   #   # $scope.userList = users
    #   #   deferred.resolve(businesses)
    #   # return deferred.promise
    #   return RestangularPlus.getListPlus2("businesses")


        # alert Utilities.entityCompare()
    $scope.sentMessageInit = (newPost)->
      newPost.type = "SentMessage"

    $scope.selectEntity = (displayEntity)->
      $scope.selectedEntity = displayEntity
      # $scope.getAllMessages($scope.selectedEntity).then (all)->
      #   $scope.allMessages = all

    $scope.receivedMessageInit = (newPost)->
      newPost.type = "ReceivedMessage"

    $scope.sendPost = (postObj, postSubmit)->
      selectedEntity = AuthService.currentEntitySelection.selected
      entityAttrs = 
        from_id: selectedEntity.id
        from_type: selectedEntity.type
        # to_id: postObj.entityId
        # to_type: postObj.entityType
        to_id: $scope.selectedEntity.id
        to_type: $scope.selectedEntity.type
        type: "Message"

      # entityAttrs = 
      #   parent_id: postObj.id
      #   entity_id: selectedEntity.id
      #   entity_type: selectedEntity.type
      #   from_id: selectedEntity.id 
      #   from_type: selectedEntity.type
      #   to_id: postObj.entityId
      #   to_type: postObj.entityType
      #   type: "MessageResponse"

      postSubmit = angular.extend({}, postSubmit, entityAttrs)


      # route = selectedEntity.message_route
      # alert JSON.stringify postSubmit
      selectedEntity.post('messages', postSubmit).then (response)->
        $scope.getAllMessages($scope.selectedEntity).then (all)->
          $scope.allMessages = all
        # $scope.posts = $scope.posts.concat(response)
          # console.log "POSTS: " + JSON.stringify posts

    $scope.$watch 'AuthService.currentEntitySelection.selected', ->
    
      currentEntity = AuthService.currentEntitySelection.selected
      # MessagesDisplay.buildMessageDisplay($scope.sentMessagesDisplay, $scope.sentMessages)
      # $scope.allMessages = []
      # $scope.displayEnt().allMessages = []

      $scope.getAllMessages(currentEntity).then (all)->
        # $scope.allMessages = all
        $scope.displayEnt().allMessages = all
        for m in all
          console.log [m.id, m.type]
        # $scope.displayEnt().entitiesList = []
        # $scope.displayEnt().buildEntitiesList()

        # $scope.displayEnt().buildEntitiesList()

        # for array in $scope.displayEnt().buildEntitiesList()
        #   p = array[1]
        #   m = array[0]

        #   do (p, m) ->
        #     p.then (e)->
        #       console.log e
        $q.all($scope.displayEnt().buildEntitiesList()).then (entities) ->
          # debugger\
          $scope.displayEnt().entitiesList = []
          # console.log entities
      

          for entity in _.uniq entities
            displaySubEnt = new MessageEntity(entity)
            $scope.displayEnt().entitiesList.push(displaySubEnt)
            MessageService.buildEntityMessageList(displaySubEnt, $scope.displayEnt().allMessages)
            MessagesDisplay.buildMessageDisplay2(displaySubEnt.displayMessages, displaySubEnt.messages, {suppressResponses: true})

          $scope.selectedEntity = $scope.displayEnt().getEntitiesList()[0]
          
      
      # MessageService.loadUnreadMessages().then (msgs)->
      #   $scope.MessageService.unreadList = msgs

      #   MessageService.buildEntityUnreadList($scope.entityList, msgs, currentEntity)      
      #   $scope.getAllMessages($scope.selectedEntity).then (all)->
      #     $scope.allMessages = all

      # $scope.posts = $scope.post

    # $scope.$watch 'allMessages', ->
    #   # MessagesDisplay.buildMessageDisplay($scope.sentMessagesDisplay, $scope.sentMessages)
    #   MessagesDisplay.buildMessageDisplay2($scope.displayMessages, $scope.allMessages, {suppressResponses: true})

    # $scope.$watch 'displayEnt().', ->
    #   # MessagesDisplay.buildMessageDisplay($scope.sentMessagesDisplay, $scope.sentMessages)
    #   Mess


    # $scope.$watch 'receivedMessages', ->
    #   # MessagesDisplay.buildMessageDisplay($scope.receivedMessagesDisplay, $scope.receivedMessages)
    #   MessagesDisplay.buildMessageDisplay(null, $scope.receivedMessages).then (list)->
    #     $scope.receivedMessagesDisplay = list

    # $scope.$watch 'AuthService.currentEntitySelection.selected', ->
    #   if AuthService.currentEntitySelection.selected
        
    
      
]