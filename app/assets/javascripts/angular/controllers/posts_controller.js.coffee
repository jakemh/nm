angular.module("NM").animation ".slide", ->
  NG_HIDE_CLASS = "ng-hide"
  beforeAddClass: (element, className, done) ->
    element.slideUp done  if className is NG_HIDE_CLASS
    return

  removeClass: (element, className, done) ->
    element.hide().slideDown done  if className is NG_HIDE_CLASS
    return

angular.module("NM").controller "PostController", [
  "$scope"
  "$q"
  "CacheService"
  "Utilities"
  "MessagesDisplay"
  "Restangular"
  "AuthService"
  ($scope, $q, CacheService, Utilities, MessagesDisplay,  Restangular, AuthService) ->
    # $scope.postsCache = $cacheFactory('me/posts');
    $scope.posts = []
    $scope.displayList = null
    $scope.searching = [] 
    $scope.AuthService = AuthService
    $scope.Utilities = Utilities
    $scope.feedHeadBody = "feed_head_form.html"
    $scope.feedCornerPartial = "feed_body_comment.html"
    $scope.currentSelected = AuthService.currentEntitySelection.selected
    $scope.newPostMain = {}
    $scope.newPostBody = {}
    $scope.buildFeedList = false
    $scope.displayCommentForm = true
    # Restangular.all('me/posts').post({content: "XYZ"})
    $scope.headOuterInit = (newPost, entity) ->
      newPost.type = 'Post'
    
    $scope.commentClick = ()->

    $scope.commentHeadOuterInit = (newPost, entity) ->
      # newPost = entity.newPost
      newPost.type = 'Response'
      newPost.parent_id = entity.id
      # newPost.entity_id = AuthService.currentEntitySelection.selected.id
      # newPost.entity_type = AuthService.currentEntitySelection.selected.type

    $scope.sendPost = (postObj, postSubmit)->
      entityAttrs = 
          entity_id: AuthService.currentEntitySelection.selected.id
          entity_type: AuthService.currentEntitySelection.selected.type

      postSubmit = angular.extend({}, postSubmit, entityAttrs)
      Restangular.all('me/posts').post(postSubmit).then (response)->
        # $scope.posts = $scope.posts.concat(response)
        AuthService.currentUser.posts().then (posts) ->
          # console.log "POSTS: " + JSON.stringify posts
          $scope.posts = posts
      # Restangular.all('me/posts').post(post)

    $scope.$watch 'posts', ->
      MessagesDisplay.buildMessageDisplay(null, $scope.posts).then (list)->

        $scope.displayList = list
        console.log "TEST: " + JSON.stringify list
      # MessagesDisplay.buildMessageDisplay($scope.displayList, $scope.posts)

    $scope.$watch 'AuthService.currentUser', ->
      if AuthService.currentUser
        # $scope.displayList = []
        # $scope.buildAssociationCache().then () ->
        cacheHash = 
          users: AuthService.currentUser.user_post_associations
          businesses: AuthService.currentUser.business_post_associations

        CacheService.cacheModelsForLists(cacheHash).then ()->
          AuthService.currentUser.posts().then (posts) ->
            $scope.posts = posts
    
    # $scope.buildAssociationCache = ->
    #   deferred = $q.defer();
    #   # alert JSON.stringify  AuthService.currentUser.user_post_associations
    #   Restangular.several('users', AuthService.currentUser.user_post_associations).getList().then (asses)->
    #     for ass in asses
    #       # alert JSON.stringify ass
    #       UsersCache.cache.put(ass.id, ass)

    #     Restangular.several('businesses', AuthService.currentUser.business_post_associations).getList().then (asses)->
    #       for ass in asses
    #         # alert JSON.stringify ass
    #         BusinessesCache.cache.put(ass.id, ass)
    #       deferred.resolve(asses)
      

    #   return deferred.promise

    
]