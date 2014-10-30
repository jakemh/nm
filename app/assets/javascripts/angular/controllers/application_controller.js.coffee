angular.module("NM").controller "ApplicationController", [
  "$scope"
  "User"
  "SentMessage"
  "ReceivedMessage"
  "Follower"
  "Business"
  "Entity"
  "Following"
  "Post"
  "Response"
  "MessageResponse"
  "AuthService"
  "Restangular"

  ($scope, User, SentMessage, ReceivedMessage, Follower, Business, Entity, Following, Post, Response, MessageResponse, AuthService, Restangular) ->
    $scope.AuthService = AuthService

    $scope.init = () ->
      AuthService.user().then (user)->
        AuthService.currentUser = user

    $scope.init()

    $scope.$watch 'AuthService.currentUser', ->
      if AuthService.currentUser
        AuthService.currentUser.businesses().then (businesses)->

          # alert JSON.stringify businesses
          AuthService.entityOptions = [AuthService.currentUser]
          AuthService.currentEntitySelection.selected = AuthService.entityOptions[0]

          AuthService.userBusinesses = businesses
        # $scope.$apply()

    $scope.$watch 'AuthService.userBusinesses', ->
      if AuthService.userBusinesses && AuthService.currentUser
        AuthService.entityOptions = AuthService.entityOptions.concat(AuthService.userBusinesses)
        AuthService.currentEntitySelection.selected = AuthService.entityOptions[0]

    $scope.$watch 'AuthService.currentEntitySelection.selected', ->
      ent = AuthService.currentEntitySelection.selected
      if ent
        ent.followers().then (followers)->
          AuthService.currentFollowers = followers 
      # if ent
      #   Follower.query({
      #       distance: true,
      #       entity_type: ent.type, 
      #       entity_id: ent.id
      #     }).then ((results) ->
      #       AuthService.currentFollowers = results
      #       # alert JSON.stringify $scope.followers
      #       # $scope.watch "users + business"
      #       $scope.searching = false
      #       return
      #     ), (error) ->
            
      #       $scope.searching = false

]