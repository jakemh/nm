"use strict";

angular.module("NM").directive "imgCropped", ->
  restrict: "A"
  replace: true
  scope:
    src: "@"
    selected: "&"
    initCallback: "&"
    photo: "="
    maxWidth: "="
    aspectWidth: "="
    aspectHeight: "="

  link: (scope, element, attr) ->

    myImg = undefined
    clear = ->
      if myImg
        myImg.next().remove()
        myImg.remove()
        myImg = `undefined`
      return

    scope.naturalWidth = ->
      element.find(".preview")[0].naturalWidth

    scope.actualWidth = ->
      Math.min(scope.maxWidth, scope.naturalWidth())

    scope.actualHeight = ->
      element.find(".jcrop-holder").height()

    scope.aspectRatio = ->
      scope.actualWidth() / scope.actualHeight()

    scope.selectAspectRatio = ->
      scope.aspectWidth / scope.aspectHeight

    scope.maxCropBounds = ->
      bounds = 
        x: null
        y: null
        h: null
        w: null

      width = scope.actualWidth()
      height = scope.actualHeight()
      selectAr = scope.selectAspectRatio()
      ar = scope.aspectRatio()
      # inverseAspectRatio = 1 / aspectRatio

      if selectAr < ar 
        bounds.h = height
        bounds.y = 0
        bounds.w = height * selectAr
        bounds.x = (width - bounds.w) / 2
      else if selectAr > ar 
        bounds.w = width
        bounds.x = 0
        bounds.h = width * (1 / selectAr)
        bounds.y = (height - bounds.h) / 2
 
      else
        bounds.w = width
        bounds.h = height
        bounds.x = 0
        bounds.y = 0

      return bounds


    scope.cropPhoto = (coords)->
      # x = scope.maxCropBounds()
      
      ratio = scope.naturalWidth() / scope.actualWidth()
      
      scope.photo.crop_x = coords.x * ratio
      scope.photo.crop_y = coords.y * ratio
      scope.photo.crop_h = coords.h * ratio
      scope.photo.crop_w = coords.w * ratio



    scope.setPreviewWindow = (coords) ->
      boundx = scope.actualWidth()
      boundy = scope.actualHeight()
      rx = scope.aspectWidth / coords.w
      ry = scope.aspectHeight / coords.h
      element.find(".preview").css
        width: Math.round(rx * boundx) + "px"
        height: Math.round(ry * boundy) + "px"
        marginLeft: "-" + Math.round(rx * coords.x) + "px"
        marginTop: "-" + Math.round(ry * coords.y) + "px"

      
    scope.$watch "src", (nv) ->
      clear()

      if nv
        img = element.find(".img-cropped")
        img.css(maxWidth: scope.maxWidth)
        img.attr "src", nv
        $(img).Jcrop
          aspectRatio: scope.selectAspectRatio() #If you want to keep aspectRatio
          boxWidth: scope.maxWidth  #Maximum width you want for your bigger images
          # boxHeight: 400,  #Maximum Height for your bigger images
            
          trackDocument: true
          onSelect: (x) ->
            scope.cropPhoto(x)
            boundx = scope.actualWidth()
            boundy = scope.actualHeight()
            console.log @getBounds()
            console.log [boundx, boundy]
            scope.setPreviewWindow(x)
            return
        , ->
          defaultCropCoords = scope.maxCropBounds()
          scope.setPreviewWindow(defaultCropCoords)
          scope.cropPhoto(defaultCropCoords)
          scope.initCallback()
          return
        

      return

    scope.$on "$destroy", clear
    return


angular.module("NM").controller "ProfileController", [
  
  "$scope"
  "$sce"
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
  "usSpinnerService"
  "PointService"
  ($scope, $sce, $q, $routeParams, $location, Utilities, Review, AuthService, MessagesDisplay, MessageService, Restangular, SideBar, MapService, ReviewService, ReviewDisplay, profileEntity, usSpinnerService, PointService) ->
    
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
    $scope.reviews = []

    $scope.currentCoords = null
    $scope.spinnerVisible = false
    $scope.photoCropping = false

    # $scope.messageObject 
    # SideBar.delegate.submitHandler = ReviewService.sendReview
    # SideBar.delegate.messageObject = (newPost) ->
    #   ReviewService.initReviewModal(angular.copy(newPost), profileEntity, $scope.reviewCallback);
    #   newPost = $scope.reviewPost

    # SideBar.delegate.messageObject = (newPost) ->
    #   o = ReviewService.initReviewModal(newPost, profileEntity, $scope.reviewCallback);
    #   SideBar.delegate.newPost = angular.copy($scope.reviewPost)
    #   return o

    $scope.alreadyVoted = (post) ->
      moment(post.last_vote_current_user).add(1, "days").diff(moment()) > 0


    $scope.disableTop = PointService.disableTop
    $scope.disableBottom = PointService.disableBottom
    $scope.existingScore = PointService.existingScore
    $scope.upVote = PointService.upVote
    $scope.downVote = PointService.downVote

    $scope.cropperCallback = ->
      $scope.stopSpin('spinner-1')

    $scope.selected = (coords) ->

      # alert JSON.stringify coords 
    $scope.lastPhotoObj = (array) ->
      if array[array.length - 1]
        array[array.length - 1]

    $scope.lastPhoto = (array) ->
      if array[array.length - 1]
        array[array.length - 1].url

    $scope.trustSrc = (src) ->
       return $sce.trustAsResourceUrl(src);

    $scope.startSpin = (key) ->
      usSpinnerService.spin key
      $scope.spinnerVisible = true
      return

    $scope.stopSpin = (key) ->
      usSpinnerService.stop key
      $scope.spinnerVisible = false
      $scope.$apply()

      return

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
    # SideBar.delegate.profile = $scope
    # SideBar.delegate.ReviewService = ReviewService
    # SideBar.delegate.rateFunction = ReviewService.rateFunction
    # SideBar.delegate.userBusinesses = []
    # SideBar.delegate.getBusiness = ->
    #   $scope.businessOwner


    # $scope.SideBar.delegate.getBusinessOwner = ->
    #   $scope.businessOwner

    # SideBar.delegate.entity = profileEntity
    # SideBar.delegate.newPost = angular.copy($scope.reviewPost)
    # SideBar.delegate.validateStars = false

    # ReviewService.entity = $scope.profileEntity
    $scope.reviews = []
    # SideBar.delegate.reviews = $scope.reviews
    $scope.yours = null

    
    $scope.setItemDelegate = (business) ->
      delegate = 
      message:
        newPost: {}
        validationHandler: MessageService.submitHandler
        submitHandler: MessageService.sendMessage
        messageObject: (newPost) ->
          o = MessageService.initMessageModal(newPost, business, null)
          $scope.delegate.newPost = {}
          return o
      

      getBusiness: ->
        business

      return delegate
    # SideBar.delegate.itemDelegate = $scope.setItemDelegate

    $scope.isYours = ->
      return $scope.yours

    # SideBar.delegate.isYours = $scope.isYours
    # SideBar.delegate.profileEntity = profileEntity
    # SideBar.delegate.businessOwner = $scope.businessOwner

    $scope.reviewValidate = (obj, entryForm, submit) ->

      if obj.reviewObj.score > 0
        
        MessageService.submitHandler(obj, entryForm, submit)
      else 
        SideBar.delegate.validateStars = true

    $scope.reviewCallback = (response) ->
      $("#js__business-review-modal").modal('hide')
      $scope.buildReviewList()

    # SideBar.delegate.validationHandler = $scope.reviewValidate
    # SideBar.delegate.reviewCallback = $scope.reviewCallback


    # SideBar.delegate.sendPost = $scope.sendReview
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
      # photo = JSON.parse photo
      # key = Object.keys(photo)[0];
      # $scope.uploadedProfilePhotos.push(photo[key])
      photo = JSON.parse photo
      key = Object.keys(photo)[0];
      photo = photo[key]

      restPhoto = Restangular.restangularizeElement($scope.profileEntity, photo, 'profile_photos')
      $scope.uploadedProfilePhotos.push(restPhoto)

    $scope.approveProfilePhoto = (photo) ->
      $scope.photoCropping = true

      photo.put().then (photo) ->
        $scope.profileEntity.profile_photo_id = photo.id 
        $scope.profileEntity.put().then (entity)->
          $scope.profileEntity.thumb = entity.thumb
          $scope.photoCropping = false

          $("#js__profile-photo-modal").modal('hide')
      return true

    $scope.approveCoverPhoto = (photo) ->
      $scope.photoCropping = true
      # photo = delegate.photoArray[delegate.photoArray.length - 1]
      photo.put().then (photo) ->
        $scope.profileEntity.cover_photo_id = photo.id 
        $scope.profileEntity.put().then (entity)->
          $scope.profileEntity.cover_photo_url = entity.cover_photo_url
          $scope.photoCropping = false

          $("#js__cover-photo-modal").modal('hide')
      return true

    $scope.coverPhotoUploaded = (photo)->        
        photo = JSON.parse photo
        key = Object.keys(photo)[0];
        photo = photo[key]

        restPhoto = Restangular.restangularizeElement($scope.profileEntity, photo, 'cover_photos')
        $scope.uploadedCoverPhotos.push(restPhoto)

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
      AuthService.currentUser.flag(profileEntity).then (response)->
        $scope.sentFlag = true  

    $scope.initRightBarExternal = ->
      $scope.loadBusinesses()

    $scope.initSecondaryBox = () ->
      $scope.profileEntity.getItems().then (items) -> 

        $scope.profileEntity.items = items
    
    $scope.initSecondaryBoxBusiness = () ->
     

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

      # current = AuthService.currentEntitySelection.selected
      # AuthService.currentEntitySelection.selected.pushFollowing(entity)


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
    
    # $scope.messageObject 

    $scope.delegate = 
      newPost: {}
      validationHandler: MessageService.submitHandler
      submitHandler: MessageService.sendMessage
      messageObject: (newPost) ->
        o = MessageService.initMessageModal(newPost, profileEntity, null)
        $scope.delegate.newPost = {}
        return o

    angular.extend SideBar.delegate, 
      isYours: $scope.isYours
      profileEntity: profileEntity
      itemDelegate: @itemDelegate || $scope.setItemDelegate
      userBusinesses: []
      businessOwner: null
      getBusiness: ->
        @businessOwner

      getBusinessOwner: ->
        @businessOwner

      review:
        newPost: angular.copy $scope.reviewPost
        validationHandler: MessageService.submitHandler
        submitHandler: ReviewService.sendReview
        rateFunction: ReviewService.rateFunction
        validateStars: false

        messageObject: (newPost) ->
          o = ReviewService.initReviewModal(angular.copy(newPost), profileEntity, $scope.reviewCallback);
          @newPost = angular.copy($scope.reviewPost)
          return o
          
      entity: profileEntity
      reviews: $scope.reviewList
      
    $scope.init = () ->
      if profileEntity.type == "Business"
        $scope.profileEntity.owner().then (o)->
          $scope.businessOwner = o
          SideBar.delegate.businessOwner = o

      $scope.profileEntity.getItems().then (items) -> 
        $scope.profileEntity.items = items

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
            MapService.resetMap(MapService.coordsArray)

          SideBar.rightBarTemplate = "right_bar_business.html"
    
      
]