angular.module("NM").controller "LeftBarController", [
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
      SideBar.allUnreadMessages(AuthService.currentUser).then (list) ->
        SideBar.messageCount = list.length

      SideBar.eachEntityUnreadMessages(AuthService.currentUser)

      # AuthService.user()
      #   .then (user)->
      #     return user.ownedEntities()
          
      #   .then (entities) ->

      #     for entity in entities
      #       entity.
      # MessageService.loadUnreadMessages(AuthService.currentUser).then (unreadList)->
      #   $scope.MessageService.unreadList = unreadList
      #   AuthService.currentUser.ownedEntities().then (entities) ->
      #     $scope.MessageService.buildUserEntityUnreadList(unreadList, entities)
        # $scope.SideBar.messageCount = $scope.MessageService.unreadList.length


    $scope.$watch 'MessageService.unreadList', ->
      $scope.SideBar.messageCount = $scope.MessageService.unreadList.length

]