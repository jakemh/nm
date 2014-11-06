angular.module("NM").directive "editableToggle", ->
  template: 
    ''' 
    <a href ng-if=true editable-text={{attr}}>  
      {{attrEval || default}}
    </a>
    <span ng-if=false>{{attrEval}}</span>

    '''

  scope:
    default: "@default"
    attr: "@attr"
    attrEval: "&attr"

    toggle: "@toggle"

angular.module("NM").controller "PrivateMessageController", [
  "$scope"
  "AuthService"
  "Restangular"
  "MessageService"

  ($scope, AuthService, Restangular, MessageService) ->
    $scope.messageForm = "message_form.html"
    $scope.feedCornerPartial = "feed_body_comment.html"
    $scope.newPostMain = {}
   

    $scope.sendPost = (postObj, postSubmit)->
      selectedEntity = AuthService.currentEntitySelection.selected
      entityAttrs = 
        entity_id: selectedEntity.id
        entity_type: selectedEntity.type
        from_id: selectedEntity.id
        from_type: selectedEntity.type
        to_id: MessageService.messageEntity.id
        to_type: MessageService.messageEntity.type
        type: "Message"

      postSubmit = angular.extend({}, postSubmit, entityAttrs)

      route = selectedEntity.message_route
      selectedEntity.post("messages", postSubmit).then (response)->
        # $scope.posts = $scope.posts.concat(response)
        AuthService.currentUser.sentMessages().then (sentMessages) ->
          $("#js-msg__modal").modal('hide')

    # $scope.sendPost = (postObj, postSubmit)->
    #   entityAttrs = 
    #     entity_id: AuthService.currentEntitySelection.selected.id
    #     entity_type: AuthService.currentEntitySelection.selected.type

    #   postSubmit = angular.extend({}, postSubmit, entityAttrs)
    #   Restangular.all('me/posts').post(postSubmit).then (response)->
    #     ("#js-msg__modabowel").modal('hide')


        # $scope.posts = $scope.posts.concat(response)
        # $scope.profileEntity.personalPosts().then (posts)->
        #   $scope.posts = posts
]

angular.module("NM").controller "ProfileController", [
  
  "$scope"
  "$routeParams"
  "$location"
  "Utilities"
  "AuthService"
  "MessagesDisplay"
  "MessageService"
  "Restangular"
  
  ($scope, $routeParams, $location, Utilities, AuthService, MessagesDisplay, MessageService, Restangular) ->
    
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
    $scope.followButtonText = "Follow"
    $scope.isFollowing = false

    # $scope.skills = []

    $scope.init = () ->
      if AuthService.currentUser
        $scope.params = _.compact($scope.location.path().split("/"))
        current = AuthService.currentUser
        params = {current_type: current.type, current_id: current.id}
        Restangular.one($scope.params[0], $scope.params[1]).get(params).then (entity)->
          # $scope.posts = $scope.posts.concat(response)
          $scope.profileEntity = entity
          $scope.profileEntity.getSkills().then (skills) -> 
            $scope.profileEntity.skills = skills

          # $scope.isFollowing = entity.follower_uri_type == -1 ? false : true
          # alert JSON.stringify entity.follower_uri_type 
          if entity.follower_uri_type == -1
            $scope.isFollowing = true
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
        
      # else if profileEntity

    $scope.loadBusinesses = () ->
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
      
    $scope.$watch 'profileEntity', ->

      if $scope.profileEntity
        $scope.profileEntity.posts().then (posts)->
          $scope.posts = posts
        $scope.loadBusinesses()
          # alert JSON.stringify posts

    $scope.$watch 'posts', ->
      MessagesDisplay.buildMessageDisplay(null, $scope.posts).then (list)->
        # alert JSON.stringify list 
        $scope.displayList = list
    
      
]