angular.module("NM").controller "PrivateMessageController", [
  "$scope"
  "AuthService"
  "Restangular"
  "MessageService"

  ($scope, AuthService, Restangular, MessageService) ->
    $scope.messageForm = "message_form.html"
    $scope.feedCornerPartial = "feed_body_comment.html"
    $scope.newPostMain = {}

    $scope.sendPost = (postObj, postSubmit)->
      currentEntity = AuthService.currentEntitySelection.selected

      toEntity = $scope.profileEntity
      entityAttrs = 
        from_id: currentEntity.id
        from_type: currentEntity.type
        # to_id: postObj.entityId
        # to_type: postObj.entityType
        to_id: toEntity.id
        to_type: toEntity.type
        type: "Message"

     
      postSubmit = angular.extend({}, postSubmit, entityAttrs)


      # route = selectedEntity.message_route
      # alert JSON.stringify postSubmit
      currentEntity.post('messages', postSubmit).then (response)->
        $("#js-msg__modal").modal('hide')

    $scope.messageObject = (newPost) ->
      debugger
      o = MessageService.initMessageModal(newPost, profileEntity, null)
      $scope.delegate.newPost = {}
      return o

    $scope.delegate = 
      newPost: {}
      validationHandler: MessageService.submitHandler
      submitHandler: MessageService.sendMessage
      messageObject: $scope.messageObject
]