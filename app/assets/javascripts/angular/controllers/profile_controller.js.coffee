"use strict";

angular.module("NM").controller "ProfileController", [
  
  "$scope"
  "$q"
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

  ($scope, $q, $routeParams, $location, Utilities, Review, AuthService, MessagesDisplay, MessageService, Restangular, SideBar, MapService, ReviewService, ReviewDisplay, profileEntity) ->
    
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
    $scope.isFollowing = (userEntity) ->
      pe = $scope.profileEntity
      return pe.canBeFollowedBy(userEntity) && pe.isFollowedBy(userEntity)

    $scope.followButtonText = "Follow"
    $scope.SideBar = SideBar
    SideBar.tabBarVisible = true
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
    SideBar.delegate.userBusinesses = []
    SideBar.delegate.entity = profileEntity
    SideBar.delegate.review = $scope.reviewPost
    SideBar.delegate.validateStars = false

    # ReviewService.entity = $scope.profileEntity
    $scope.reviews = []
    SideBar.delegate.reviews = $scope.reviews
    $scope.yours = null

    $scope.init = () ->
    
      $scope.profileEntity.personalPosts().then (posts)->
        $scope.posts = posts

      # if AuthService.currentUser
      current = AuthService.currentUser

      if profileEntity == AuthService.currentUser
        $scope.yours = true
      $scope.userOrBelongsToUser().then (belongs)->

        $scope.yours = belongs

        if $scope.yours
          AuthService.currentEntitySelection.selected = $scope.profileEntity

        if $scope.profileEntity.type == "User"

          if $scope.yours
            SideBar.rightBarTemplate = "right_bar_profile_internal.html" 
          else 
            SideBar.rightBarTemplate = "right_bar_profile_external.html"  
            profileEntity.businesses().then (businesses) ->
              SideBar.delegate.userBusinesses = businesses

        else if $scope.profileEntity.type == "Business" 
          $scope.buildReviewList()
          MapService.coordsArray = MapService.mapToMarker([profileEntity])

          if MapService.mapObj
            MapService.mapObj.removeMarkers()
            MapService.resetMap(MapService.coordsArray)

          SideBar.rightBarTemplate = "right_bar_business.html"
 

    $scope.isYours = ->
      return $scope.yours

    SideBar.delegate.isYours = $scope.isYours
    SideBar.delegate.profileEntity = profileEntity
    SideBar.delegate.businessOwner = $scope.businessOwner

    $scope.sendReview = (business, post) ->
      if post.score > 0
        ReviewService.sendPost(business, post).then (response) ->
          $("#js__business-review-modal").modal('hide')
          $scope.buildReviewList()

      else 
        SideBar.delegate.validateStars = true
    SideBar.delegate.sendPost = $scope.sendReview
    $scope.uploadedProfilePhotos = []
    $scope.uploadedCoverPhotos = []

    $scope.tabItemClick = (entity)->

    # $scope.initMap = () -> 
    #   setTimeout ->
    #     $scope.MapService.mapObj.refresh()
    #   , 100

    $scope.profilePhotoUploaded = (photo)->
      # $scope.profileEntity.cover_photo_url = photo
      # $scope.profileEntity.thumb = photo
      # alert JSON.stringify {"TEST": [1,3,3]}
      photo = JSON.parse photo
      key = Object.keys(photo)[0];
      $scope.uploadedProfilePhotos.push(photo[key])

    $scope.approveProfilePhoto = (photo) ->
      $scope.profileEntity.profile_photo_id = photo.id 
      $scope.profileEntity.put().then (entity)->
        $scope.profileEntity.thumb = entity.thumb
      $("#js__profile-photo-modal").modal('hide')
      return true

    $scope.approveCoverPhoto = (photo) ->
      $scope.profileEntity.cover_photo_id = photo.id 
      $scope.profileEntity.put().then (entity)->
        $scope.profileEntity.cover_photo_url = entity.cover_photo_url
      $("#js__cover-photo-modal").modal('hide')
      return true

    $scope.coverPhotoUploaded = (photo)->
      photo = JSON.parse photo
      key = Object.keys(photo)[0];
      
      $scope.uploadedCoverPhotos.push(photo[key])

    $scope.coverPhotoModalInit = () ->
      photoType: 'CoverPhoto'
      message: "Upload cover photo here"
      successCallback: $scope.coverPhotoUploaded
      approval: $scope.approveCoverPhoto
      photoArray: $scope.uploadedCoverPhotos

    $scope.profilePhotoModalInit = () ->
      photoType: 'ProfilePhoto'
      message: "Upload profile photo here"
      successCallback: $scope.profilePhotoUploaded
      approval: $scope.approveProfilePhoto
      photoArray: $scope.uploadedProfilePhotos


    $scope.addProfilePhoto = ->
      $("#js__profile-photo-modal").modal()
      return true

    $scope.addCoverPhoto = ->
      $("#js__cover-photo-modal").modal()
      return true

    $scope.flag = ->
      $scope.profileEntity.flag().then (response)->
        $scope.sentFlag = true  

    $scope.initRightBarExternal = ->
      $scope.loadBusinesses()

    $scope.initSecondaryBox = () ->
      $scope.profileEntity.getItems().then (items) -> 

        $scope.profileEntity.items = items
    
    $scope.initSecondaryBoxBusiness = () ->
      $scope.profileEntity.owner().then (o)->
        $scope.businessOwner = o
      $scope.profileEntity.getItems().then (items) -> 
        $scope.profileEntity.items = items

    $scope.buildReviewList = () ->
      $scope.profileEntity.getReviews().then (reviews)->
        $scope.profileEntity.reviews = reviews
        ReviewDisplay.buildReviewList($scope.profileEntity.reviews, $scope.reviewList)

   
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

    $scope.followerCallback = (entity)->

      current = AuthService.currentEntitySelection.selected
      AuthService.currentEntitySelection.selected.pushFollowing(entity)

      # $scope.params = _.compact($scope.location.path().split("/"))
      # current = AuthService.currentUser
      # params = {current_type: current.type, current_id: current.id}
      # Restangular.one($scope.params[0], $scope.params[1]).get(params).then (entity)->
      #   # $scope.posts = $scope.posts.concat(response)
      #   if entity.follower_uri_type == -1
      #     $scope.isFollowing = true
      #     $scope.profileEntity.follower_count = entity.follower_count
      #     $scope.followButtonText = "Following"
      #   else $scope.followButtonText = "Declined"

    $scope.belongsToUser = ->
      #check if profile entity is user or one of user's businesses
      deferred = $q.defer();

      AuthService.currentUser.businesses().then (businesses)->
        # if $scope.profileEntity && AuthService.userBusinesses.length > 0
        e = [$scope.profileEntity.id, $scope.profileEntity.type]
        a = _.map(businesses, (item) -> [item.id, item.type])
        c = [AuthService.currentUser.id, AuthService.currentUser.type]
        
        if angular.equals(e, c)
          deferred.resolve(true)
        else if _.where(a, e).length > 0
          deferred.resolve(true)
        else deferred.resolve(false)
      return deferred.promise

      # else if profileEntity
    $scope.userOrBelongsToUser = ()->
      deferred = $q.defer();
      
      $scope.belongsToUser($scope.profileEntity).then (doesBelong)->
        if Utilities.entityCompare(AuthService.currentUser, $scope.profileEntity)
          deferred.resolve(true)

        else if doesBelong
          deferred.resolve(doesBelong)
        else 
          deferred.resolve(false)
      return deferred.promise



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
    $scope.uploadedPhotos = []


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

    # # $scope.$watch 'AuthService.currentUser', ->
    $scope.$watch 'AuthService.currentEntitySelection.selected', ->
      if $scope.yours
        $location.path( AuthService.currentEntitySelection.selected.uri );

    $scope.$watch 'posts', ->

        MessagesDisplay.buildMessageDisplay2($scope.displayList, $scope.posts)
      
      
]