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
  "Assignment"
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
  "$routeParams"
  "RestangularPlus"


  ($scope, User, SentMessage, ReceivedMessage, Message, Follower, Business, Entity, RestEntity, Following, Post, Assignment, Review, ReviewService, Response, MessageResponse, MessageService, AuthService, Restangular, SideBar, MapService, Utilities, ProfilePhoto, CoverPhoto, $rootScope, $location, $routeParams, RestangularPlus) ->
    $scope.Utilities = Utilities
    $scope.MessageService = MessageService
    $scope.AuthService = AuthService
    $scope.SideBar = SideBar
    $scope.tabBarDisabled = true
    $scope.MapService = MapService
    $scope.delegate = SideBar.delegate
    $scope.ownedEntities = []
    $scope.routeParams = $routeParams
    $scope.tabs = [
      { title:'Dynamic Title 1', content:'Dynamic content 1' },
      { title:'Dynamic Title 2', content:'Dynamic content 2', disabled: true }
    ]

    $scope.ReviewService = ReviewService

    $scope.setCurrentEntity = (ownedEntities) ->
      businessId = $scope.routeParams.business
      if businessId
        RestangularPlus.getModel("businesses", businessId).then (b) ->
            if _.contains ownedEntities, b
              AuthService.currentEntitySelection.selected = b
            else 
              throw new Error("Attempting to use entity which is not owned");

      else
        AuthService.currentEntitySelection.selected = AuthService.currentUser


    $rootScope.visitProfile = (uri) ->
      # window.location.href = uri
      $location.path( uri );

    $scope.tabItemClick = (entity)->
      AuthService.currentEntitySelection.selected = entity
      if entity.kindOf "Business"
        $location.search('business', entity.id);
      else if entity.kindOf "User"
        $location.search('business', null)

    $scope.sideBarLoaded = false

    $scope.init = () ->
      AuthService.user()
        .then (user)->
          AuthService.currentUser = user
          # AuthService.currentEntitySelection.selected = AuthService.currentUser
          return user.ownedEntities()
          
        .then (entities) ->
          $scope.ownedEntities = entities
          $scope.setCurrentEntity(entities)

          AuthService.entityOptions = $scope.ownedEntities


]