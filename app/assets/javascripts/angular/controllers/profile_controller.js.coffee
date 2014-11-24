"use strict";

angular.module("NM").controller "ProfileController", [
  
  "$scope"
  "$routeParams"
  "$location"
  "Utilities"
  "Review"
  "AuthService"
  "MessagesDisplay"
  "MessageService"
  "Restangular"
  "SideBar"
  "MapService"
  "ReviewService"
  "ReviewDisplay"
  "profileEntity"
  
  ($scope, $routeParams, $location, Utilities, Review, AuthService, MessagesDisplay, MessageService, Restangular, SideBar, MapService, ReviewService, ReviewDisplay, profileEntity) ->
    
    # alert my#FriendsHotel.hotelName( );
    $scope.profileEntity = profileEntity

    $scope.posts = []
    $scope.params = []
    $scope.location = $location
    $scope.displayList = []
    $scope.Utilities = Utilities
    $scope.profileEntityBusinesses = []
    # $scope.profileEntity = null
    $scope.AuthService = AuthService
    $scope.reviewList = []
    $scope.newPostMain = {}
    $scope.feedHeadForm = "feed_head_form.html"
    $scope.feedHeadBody = "feed_head_form.html"
    $scope.messageForm = "message_form.html"
    $scope.feedCornerPartial = "feed_body_comment.html"
    $scope.MessageService = MessageService
    $scope.isEditable = false
    $scope.editProfileText = "Edit Profile"
    $scope.isFollowing = false
    $scope.followButtonText = "Follow"
    $scope.SideBar = SideBar
    SideBar.tabBarVisible = false
    SideBar.profileScope = $scope
    $scope.businessOwner = null
    $scope.MapService = MapService
    $scope.ReviewDisplay = ReviewDisplay
    # SideBar.tabBarDisabled = $scope.isEditable
    $scope.mapLoaded = false
    $scope.sentFlag = false
    $scope.ReviewService = ReviewService
    $scope.reviewPost = {score: 0, content: ""}
    SideBar.delegate.profile = $scope
    SideBar.delegate.ReviewService = ReviewService
    SideBar.delegate.rateFunction = ReviewService.rateFunction
    SideBar.delegate.entity = profileEntity
    SideBar.delegate.review = $scope.reviewPost
    SideBar.delegate.sendPost = ReviewService.sendPost
    # ReviewService.entity = $scope.profileEntity
    $scope.reviews = []
    SideBar.delegate.reviews = $scope.reviews
    SideBar.delegate.profileEntity = profileEntity
    SideBar.delegate.businessOwner = $scope.businessOwner
    $scope.sendReview = (postObj, postSubmit)->
      ent = AuthService.currentEntitySelection.selected
      entityAttrs = 
          entity_id: ent.id
          entity_type: ent.type

      postSubmit = angular.extend({}, postSubmit, entityAttrs)
      ent.post("reviews", postSubmit).then (response)->
        # $scope.posts = $scope.posts.concat(response)
        AuthService.currentUser.posts("all": true).then (posts) ->
          $scope.posts = posts
          MessagesDisplay.buildMessageDisplay(null, $scope.posts).then (list)->
            $scope.displayList = list

    $scope.photoUploaded = (message)->
      $("#js__cover-photo-modal").modal('hide')
      $scope.profileEntity.cover_photo_url = message

    $scope.addCoverPhoto = ->
      $("#js__cover-photo-modal").modal()
      return true

    $scope.flag = ->
      $scope.profileEntity.flag().then (response)->
        $scope.sentFlag = true  

    # $scope.skills = []
    $scope.initRightBarExternal = ->
      $scope.loadBusinesses()

    $scope.initSecondaryBox = () ->
      $scope.profileEntity.getSkills().then (skills) -> 

        $scope.profileEntity.skills = skills
    
    $scope.initSecondaryBoxBusiness = () ->
      $scope.profileEntity.owner().then (o)->
        $scope.businessOwner = o
      $scope.profileEntity.getTags().then (tags) -> 
        $scope.profileEntity.tags = _.map tags, (item) -> item.tags

    $scope.buildReviewList = () ->
      $scope.profileEntity.reviews().then (reviews)->
        $scope.reviews = reviews
        ReviewDisplay.buildReviewList($scope.reviews, $scope.reviewList)

    $scope.init = () ->
     
      if AuthService.currentUser
        $scope.params = _.compact($scope.location.path().split("/"))
        current = AuthService.currentUser
        # params = {current_type: current.type, current_id: current.id}
        # Restangular.one($scope.params[0], $scope.params[1]).get(params).then (entity)->
          # $scope.posts = $scope.posts.concat(response)
          # $scope.profileEntity = entity
        $scope.yours = $scope.userOrBelongsToUser()
        SideBar.tabBarVisible = $scope.yours
        SideBar.profileEntity = $scope.profileEntity

        if $scope.profileEntity.type == "User"

          if $scope.yours
            SideBar.rightBarTemplate = "right_bar_profile_internal.html"  
          else SideBar.rightBarTemplate = "right_bar_profile_external.html"  
        else if $scope.profileEntity.type == "Business" 
          $scope.buildReviewList()
         


          SideBar.rightBarTemplate = "right_bar_business.html"
          if MapService.mapObj
            MapService.resetMap(MapService.mapToMarker([$scope.profileEntity]))


        # $scope.isFollowing = entity.follower_uri_type == -1 ? false : true
        # alert JSON.stringify entity.follower_uri_type 
        if $scope.profileEntity.follower_uri_type == -1
          $scope.isFollowing = true
          $scope.followButtonText = "Following "

        else $scope.isFollowing = false

    $scope.$watch 'MapService.mapObj', ->
      MapService.resetMap(MapService.mapToMarker([$scope.profileEntity]))

    $scope.updateAccount = () ->
      $scope.profileEntity.put()

    $scope.editProfile = ()->

      if $scope.isEditable 
        $scope.isEditable = false
        $scope.editProfileText = "Edit Profile"
        $scope.updateAccount()
      else 
        $scope.isEditable = true
        $scope.editProfileText = "Done"

      SideBar.tabBarDisabled = $scope.isEditable


    $scope.visitProfile = (uri) ->
      # $location.path(uri);
      window.location.href = uri

    $scope.followerCallback = ->
      $scope.params = _.compact($scope.location.path().split("/"))
      current = AuthService.currentUser
      params = {current_type: current.type, current_id: current.id}
      Restangular.one($scope.params[0], $scope.params[1]).get(params).then (entity)->
        # $scope.posts = $scope.posts.concat(response)
        $scope.profileEntity = entity
        if entity.follower_uri_type == -1
          $scope.isFollowing = true
          $scope.followButtonText = "Following"

        else $scope.isFollowing = false

 

    $scope.belongsToUser = ->
      #check if profile entity is user or one of user's businesses

      if $scope.profileEntity && AuthService.userBusinesses.length > 0
        e = [$scope.profileEntity.id, $scope.profileEntity.type]
        a = _.map(AuthService.userBusinesses, (item) -> [item.id, item.type])
        c = [AuthService.currentUser.id, AuthService.currentUser.type]
        
        if angular.equals(e, c)
          return true
        else if _.where(a, e).length > 0
          return true
      return false
        
      # else if profileEntity
    $scope.userOrBelongsToUser = ->
      if Utilities.entityCompare(AuthService.currentUser, $scope.profileEntity)
        return true
      else if $scope.belongsToUser($scope.profileEntit)
        return true
      else return false


    $scope.loadBusinesses = () ->
      if $scope.profileEntity.type == "User"
        $scope.profileEntity.businesses().then (businesses)->
          # alert JSON.stringify businesses
          $scope.profileEntityBusinesses = businesses

    $scope.headOuterInit = (newPost, entity) ->
      newPost.type = 'Post'
    
    $scope.privateMessageForm = "message_form.html"

    $scope.commentHeadOuterInit = (newPost, entity) ->
      # newPost = entity.newPost
      newPost.type = 'Response'
      newPost.parent_id = entity.id
      # newPost.entity_id = AuthService.currentEntitySelection.selected.id
      # newPost.entity_type = AuthService.currentEntitySelection.selected.type

    $scope.sendPost = (postObj, postSubmit)->
      ent = AuthService.currentEntitySelection.selected
      entityAttrs = 
          entity_id: ent.id
          entity_type: ent.type

      postSubmit = angular.extend({}, postSubmit, entityAttrs)

      ent.post("posts", postSubmit).then (response)->
        # $scope.posts = $scope.posts.concat(response)
        $scope.profileEntity.posts().then (posts)->
          $scope.posts = posts
        # AuthService.currentUser.posts().then (posts) ->
        #   # console.log "POSTS: " + JSON.stringify posts

        #   $scope.posts = posts

    # $scope.$watch 'AuthService.currentUser', ->
    $scope.$watch 'AuthService.currentEntitySelection.selected', ->
      if $scope.yours
        $location.path( AuthService.currentEntitySelection.selected.uri );


    $scope.$watch 'profileEntity', ->

      if $scope.profileEntity
        $scope.profileEntity.posts().then (posts)->
          $scope.posts = posts
          # alert JSON.stringify posts

    $scope.$watch 'posts', ->
      MessagesDisplay.buildMessageDisplay(null, $scope.posts).then (list)->
        # alert JSON.stringify list 
        $scope.displayList = list
    
      
]