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

  ($scope, User, SentMessage, ReceivedMessage, Follower, Business, RestEntity, Following, Post, Review, ReviewService, Response, MessageResponse, MessageService, AuthService, Restangular, SideBar, MapService, Utilities) ->
    $scope.Utilities = Utilities
    $scope.MessageService = MessageService
    $scope.AuthService = AuthService
    $scope.SideBar = SideBar
    $scope.tabBarDisabled = true
    $scope.MapService = MapService
    $scope.delegate = SideBar.delegate
    $scope.tabs = [
      { title:'Dynamic Title 1', content:'Dynamic content 1' },
      { title:'Dynamic Title 2', content:'Dynamic content 2', disabled: true }
    ];
    $scope.ReviewService = ReviewService
    $scope.tabItemClick = (entity)->
      AuthService.currentEntitySelection.selected = entity

    $scope.sideBarLoaded = false
    $scope.init = () ->
      AuthService.user().then (user)->
        AuthService.currentUser = user
    
 

    $scope.init()
    # $scope.rightBarTemplate = "right_bar_business.html"        

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