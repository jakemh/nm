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
        $scope.SideBar.messageCount = unreadList.length


]