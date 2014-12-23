angular.module("NM").controller "ApplicationController", [
  "$scope"
  "User"
  "SentMessage"
  "ReceivedMessage"
  "Message"
  "Follower"
  "Business"
  "Entity"
  "RestEntity"
  "Following"
  "Post"
  "Review"
  "ReviewService"
  "Response"
  "MessageResponse"
  "MessageService"
  "AuthService"
  "Restangular"
  "SideBar"
  "MapService"
  "Utilities"
  "ProfilePhoto"
  "CoverPhoto"
  "$rootScope"
  "$location"


  ($scope, User, SentMessage, ReceivedMessage, Message, Follower, Business, Entity, RestEntity, Following, Post, Review, ReviewService, Response, MessageResponse, MessageService, AuthService, Restangular, SideBar, MapService, Utilities, ProfilePhoto, CoverPhoto, $rootScope, $location) ->
    $scope.Utilities = Utilities
    $scope.MessageService = MessageService
    $scope.AuthService = AuthService
    $scope.SideBar = SideBar
    $scope.tabBarDisabled = true
    $scope.MapService = MapService
    $scope.delegate = SideBar.delegate
    $scope.ownedEntities = []
    $scope.tabs = [
      { title:'Dynamic Title 1', content:'Dynamic content 1' },
      { title:'Dynamic Title 2', content:'Dynamic content 2', disabled: true }
    ]

    $scope.ReviewService = ReviewService

    
    $rootScope.visitProfile = (uri)->
      # window.location.href = uri
      $location.path( uri );

    $scope.tabItemClick = (entity)->
      AuthService.currentEntitySelection.selected = entity

    $scope.sideBarLoaded = false

    $scope.init = () ->
      AuthService.user()
        .then (user)->
          AuthService.currentUser = user
          AuthService.currentEntitySelection.selected = AuthService.currentUser
          return user.ownedEntities()
          
        .then (entities) ->
          $scope.ownedEntities = entities
          AuthService.entityOptions = $scope.ownedEntities


]