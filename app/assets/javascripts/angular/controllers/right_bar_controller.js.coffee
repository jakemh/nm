angular.module("NM").controller "RightBarController", [
  "$scope"
  "AuthService"
  "Restangular"
  "MessageService"
  "SideBar"
  "$q"

  ($scope, AuthService, Restangular, MessageService, SideBar, $q) ->
    
    $scope.SideBar = SideBar
    $scope.MessageService = MessageService
    $scope.AuthService = AuthService 

    $scope.init = () ->

    $scope.followerCallback = (entity)->
      
      current = AuthService.currentEntitySelection.selected
      AuthService.currentEntitySelection.selected.pushFollowing(entity)

      
] 