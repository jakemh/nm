angular.module("NM").controller "ProfileController", [
  
  "$scope"
  "$routeParams"
  "$location"
  "Utilities"
  "AuthService"
  "MessagesDisplay"
  "MessageService"
  "Restangular"
  "SideBar"
  ($scope, $routeParams, $location, Utilities, AuthService, MessagesDisplay, MessageService, Restangular, SideBar) ->
    
    $scope.posts = []
    $scope.params = []
    $scope.location = $location
    $scope.displayList = []
    $scope.Utilities = Utilities
    $scope.profileEntityBusinesses = []
    $scope.profileEntity = null
    $scope.AuthService = AuthService
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
    # SideBar.tabBarDisabled = $scope.isEditable
    $scope.mapLoaded = false
    

    $scope.flag = ->
      $scope.profileEntity.flag() 

    $scope.$watch "SideBar.mapLoaded", ->
      if SideBar.mapLoaded == true

        $scope.mapObj = new GMaps
          div: '#map'
          lat: 35
          lng: -122
          zoom: 2
        $scope.mapLoaded = true
      SideBar.mapLoaded = false

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


    $scope.init = () ->
     
      if AuthService.currentUser
        $scope.params = _.compact($scope.location.path().split("/"))
        current = AuthService.currentUser
        params = {current_type: current.type, current_id: current.id}
        Restangular.one($scope.params[0], $scope.params[1]).get(params).then (entity)->
          # $scope.posts = $scope.posts.concat(response)
          $scope.profileEntity = entity
          $scope.yours = $scope.userOrBelongsToUser()
          SideBar.tabBarVisible = $scope.yours
          SideBar.profileEntity = $scope.profileEntity

          if $scope.profileEntity.type == "User"
            if $scope.yours
              SideBar.rightBarTemplate = "right_bar_profile_internal.html"  
            else SideBar.rightBarTemplate = "right_bar_profile_external.html"  
          else if $scope.profileEntity.type == "Business" 
            SideBar.rightBarTemplate = "right_bar_business.html"
          

          # $scope.isFollowing = entity.follower_uri_type == -1 ? false : true
          # alert JSON.stringify entity.follower_uri_type 
          if entity.follower_uri_type == -1
            $scope.isFollowing = true
            $scope.followButtonText = "Following "

          else $scope.isFollowing = false

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