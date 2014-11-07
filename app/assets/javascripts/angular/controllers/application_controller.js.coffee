angular.module("NM").controller "ApplicationController", [
  "$scope"
  "User"
  "SentMessage"
  "ReceivedMessage"
  "Follower"
  "Business"
  "RestEntity"
  "Following"
  "Post"
  "Response"
  "MessageResponse"
  "AuthService"
  "Restangular"
  "SideBar"

  ($scope, User, SentMessage, ReceivedMessage, Follower, Business, RestEntity, Following, Post, Response, MessageResponse, AuthService, Restangular, SideBar) ->
    $scope.AuthService = AuthService
    $scope.SideBar = SideBar

    $scope.sideBarLoaded = false
    $scope.init = () ->
      AuthService.user().then (user)->
        AuthService.currentUser = user
    
    $scope.mapLoaded = ->
      $scope.sideBarLoaded = true

    $scope.init()
    $scope.rightBarTemplate = "right_bar_business.html"        

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

]