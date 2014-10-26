angular.module("NM").controller "MessagesController", [
  "$scope"
  "Utilities"
  "Message"
  "AuthService"
  ($scope,  Utilities,  Message, AuthService) ->
    $scope.messages = []
    $scope.searching = []
    $scope.AuthService = AuthService
    $scope.Utilities = Utilities
    $scope.displayMessages = []

    $scope.$watch 'AuthService.currentUser', ->
      if AuthService.currentUser
        Message.query({userId: currentUser.id}).then ((results) ->
          # $scope.displayList = results["entities"]
          # alert JSON.stringify results["businesses"]
          # $scope.searching = false
          alert JSON.stringify results
          return
        ), (error) ->
        
        $scope.messages = AuthService.currentUser.messages
        alert JSON.stringify AuthService.currentUser.messages
]