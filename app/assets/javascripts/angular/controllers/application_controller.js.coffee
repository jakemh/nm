angular.module("NM").controller "ApplicationController", [
  "$scope"
  "User"
  "Follower"
  "AuthService"

  ($scope, User, Follower, AuthService) ->
    $scope.AuthService = AuthService

    $scope.init = () ->
      AuthService.user().then (user)->
        AuthService.currentUser = user
    $scope.init()

    $scope.$watch 'AuthService.currentUser', ->
      if AuthService.currentUser
        AuthService.userBusinesses = AuthService.currentUser.businesses
        # $scope.$apply()

    $scope.$watch 'AuthService.userBusinesses', ->
      if AuthService.currentUser
        AuthService.entityOptions = [AuthService.currentUser].concat(AuthService.userBusinesses)
        AuthService.currentEntitySelection.selected = AuthService.entityOptions[0]

    $scope.$watch 'AuthService.currentEntitySelection.selected', ->
      ent = AuthService.currentEntitySelection.selected
      if ent
        Follower.query({
            distance: true,
            entity_type: ent.type, 
            entity_id: ent.id
          }).then ((results) ->
            AuthService.currentFollowers = results
            # alert JSON.stringify $scope.followers
            # $scope.watch "users + business"
            $scope.searching = false
            return
          ), (error) ->
            
            $scope.searching = false

]