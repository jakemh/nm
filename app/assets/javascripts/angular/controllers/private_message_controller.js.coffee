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
      selectedEntity = AuthService.currentEntitySelection.selected
      entityAttrs = 
        entity_id: selectedEntity.id
        entity_type: selectedEntity.type
        from_id: selectedEntity.id
        from_type: selectedEntity.type
        to_id: MessageService.messageEntity.id
        to_type: MessageService.messageEntity.type
        type: "Message"

      postSubmit = angular.extend({}, postSubmit, entityAttrs)

      route = selectedEntity.message_route
      selectedEntity.post("messages", postSubmit).then (response)->
        # $scope.posts = $scope.posts.concat(response)
        AuthService.currentUser.sentMessages().then (sentMessages) ->
          $("#js-msg__modal").modal('hide')

]