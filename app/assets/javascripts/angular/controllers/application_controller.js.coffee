angular.module("NM").controller "ApplicationController", [
  "$scope"
  "User"
  "AuthService"
  ($scope, User, AuthService) ->
    $scope.posts = []
    $scope.searching = []
    $scope.init = ->

      User.query({id: "current"}).then (results) ->
        AuthService.user = results[0]
        # $scope.$apply()
        # currentUser.setCurrentUser(results[0])

    $scope.init()
]