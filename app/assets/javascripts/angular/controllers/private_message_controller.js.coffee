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
      currentEntity.post('messages', postSubmit).then (response)->
        $("#js-msg__modal").modal('hide')

        # $scope.getAllMessages($scope.selectedEntity).then (all)->
        #   $scope.allMessages = all

    # $scope.sendPost = (postObj, postSubmit)->
    #   selectedEntity = AuthService.currentEntitySelection.selected
    #   entityAttrs = 
    #     entity_id: selectedEntity.id
    #     entity_type: selectedEntity.type
    #     from_id: selectedEntity.id
    #     from_type: selectedEntity.type
    #     to_id: MessageService.messageEntity.id
    #     to_type: MessageService.messageEntity.type
    #     type: "Message"

    #   postSubmit = angular.extend({}, postSubmit, entityAttrs)

    #   route = selectedEntity.message_route
    #   selectedEntity.post("messages", postSubmit).then (response)->
    #     # $scope.posts = $scope.posts.concat(response)
    #     AuthService.currentUser.sentMessages().then (sentMessages) ->
    #       $("#js-msg__modal").modal('hide')

]