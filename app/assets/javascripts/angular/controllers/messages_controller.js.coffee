angular.module("NM").controller "MessagesController", [
  "$scope"
  "Utilities"
  "AuthService"
  "MessagesDisplay"
  "Restangular"
  ($scope,  Utilities, AuthService, MessagesDisplay, Restangular) ->
    # $scope.messages = []
    $scope.sentMessages = []
    $scope.receivedMessage = []
    $scope.sentMessagesDisplay = []
    $scope.receivedMessagesDisplay = []
    $scope.searching = []
    $scope.AuthService = AuthService
    $scope.Utilities = Utilities
    $scope.displayMessages = []
    $scope.newMessage = {}
    $scope.feedHeadBody = "feed_head_form.html"

    $scope.feedCornerPartial = "feed_body_comment.html"

    # $scope.headOuterInit = (newPost, entity) ->
    #   newPost.type = ''

    $sentMessageInit = (newPost)->
      newPost.type = "SentMessage"

    $receivedMessageInit = (newPost)->
      newPost.type = "ReceivedMessage"


    $scope.sendPost = (postObj, postSubmit)->
      selectedEntity = AuthService.currentEntitySelection.selected
      entityAttrs = 
        parent_id: postObj.id
        entity_id: selectedEntity.id
        entity_type: selectedEntity.type
        from_id: selectedEntity.id
        from_type: selectedEntity.type
        to_id: postObj.entityId
        to_type: postObj.entityType
        type: "MessageResponse"

      postSubmit = angular.extend({}, postSubmit, entityAttrs)


      route = selectedEntity.message_route
      # alert JSON.stringify postSubmit
      Restangular.all(route).post(postSubmit).then (response)->
        # $scope.posts = $scope.posts.concat(response)
        AuthService.currentUser.sentMessages().then (sentMessages) ->
          # console.log "POSTS: " + JSON.stringify posts

          $scope.sentMessages = sentMessages

    $scope.$watch 'sentMessages', ->
      # MessagesDisplay.buildMessageDisplay($scope.sentMessagesDisplay, $scope.sentMessages)
      MessagesDisplay.buildMessageDisplay(null, $scope.sentMessages).then (list)->
        $scope.sentMessagesDisplay = list


    $scope.$watch 'receivedMessages', ->
      # MessagesDisplay.buildMessageDisplay($scope.receivedMessagesDisplay, $scope.receivedMessages)
      MessagesDisplay.buildMessageDisplay(null, $scope.receivedMessages).then (list)->
        $scope.receivedMessagesDisplay = list

    $scope.$watch 'AuthService.currentEntitySelection.selected', ->
      if AuthService.currentEntitySelection.selected
        AuthService.currentEntitySelection.selected.sentMessages().then (sent) ->
          $scope.sentMessages = sent

        AuthService.currentEntitySelection.selected.receivedMessages().then (received) ->
          $scope.receivedMessages = received

    
      
]