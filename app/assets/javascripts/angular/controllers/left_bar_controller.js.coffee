angular.module("NM").controller "LeftBarController", [
  "$scope"
  "AuthService"
  "Restangular"
  "MessageService"
  "SideBar"

  ($scope, AuthService, Restangular, MessageService, SideBar) ->
    
    $scope.SideBar = SideBar
    $scope.MessageService = MessageService
    $scope.AuthService = AuthService 

    $scope.init = () ->
      MessageService.loadUnreadMessages(AuthService.currentUser).then (unreadList)->
        $scope.MessageService.unreadList = unreadList
        AuthService.currentUser.ownedEntities().then (entities) ->
          $scope.MessageService.buildUserEntityUnreadList(unreadList, entities)
        # $scope.SideBar.messageCount = $scope.MessageService.unreadList.length


    $scope.$watch 'MessageService.unreadList', ->
      $scope.SideBar.messageCount = $scope.MessageService.unreadList.length

]