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
  "SideBar"

  ($scope, $q, CacheService, Utilities, MessagesDisplay,  Restangular, AuthService, SideBar) ->
    # $scope.postsCache = $cacheFactory('me/posts');
    $scope.posts = []
    $scope.postIntermediate = []
    $scope.displayList = []
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
    SideBar.rightBarTemplate = "blank.html"     

    # $scope.throttledLoadMore = _.throttle ->
    #     # alert JSON.stringify @
    #     $scope.loadMore()
    #   , 100

 



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

    $scope.followerCallback = ->
      AuthService.currentUser.posts("all": true).then (posts) ->
        $scope.posts = posts
      
    $scope.sendPost = (postObj, postSubmit)->
      ent = AuthService.currentEntitySelection.selected
      entityAttrs = 
          entity_id: ent.id
          entity_type: ent.type

      postSubmit = angular.extend({}, postSubmit, entityAttrs)
      ent.post("posts", postSubmit).then (response)->
        # $scope.posts = $scope.posts.concat(response)
        AuthService.currentUser.posts("all": true).then (posts) ->
          $scope.posts = posts
          MessagesDisplay.buildMessageDisplay(null, $scope.posts).then (list)->
            $scope.displayList = list
      # Restangular.all('me/posts').post(post)

    # $scope.$watch 'posts', ->
      # MessagesDisplay.buildMessageDisplay(null, $scope.posts).then (list)->

        # $scope.displayList = list

    $scope.$watch 'AuthService.currentUser', ->
      current = AuthService.currentEntitySelection.selected

      if AuthService.currentUser
        # $scope.displayList = []
        # $scope.buildAssociationCache().then () ->
        cacheHash = 
          users: AuthService.currentUser.user_post_associations
          businesses: AuthService.currentUser.business_post_associations

        CacheService.cacheModelsForLists(cacheHash,{current_type: current.type, current_id: current.id}).then ()->
          AuthService.currentUser.posts("all": true).then (posts) ->
            $scope.posts = posts
            MessagesDisplay.buildMessageDisplay2($scope.displayList, $scope.posts)

            # i = 0
            # while i <= 20
            #   $scope.postIntermediate.push $scope.posts[i]
            #   i++
            # MessagesDisplay.buildMessageDisplay2($scope.displayList, $scope.postIntermediate)
            # MessagesDisplay.buildMessageDisplay(null, $scope.postIntermediate).then (list)->
            #   $scope.displayList = list
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