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
  "UsersCache"
  "BusinessesCache"
  "Utilities"
  "Restangular"
  "AuthService"
  ($scope, $q, UsersCache, BusinessesCache, Utilities, Restangular, AuthService) ->
    # $scope.postsCache = $cacheFactory('me/posts');

    $scope.posts = []
    $scope.displayList = []
    $scope.searching = []
    $scope.AuthService = AuthService
    $scope.Utilities = Utilities
    $scope.feedHeadBody = "feed_head_form.html"
    $scope.feedCornerPartial = "feed_body_comment.html"
    $scope.currentSelected = AuthService.currentEntitySelection.selected
    $scope.newPostMain = {}
    $scope.newPostBody = {}

    # Restangular.all('me/posts').post({content: "XYZ"})
    $scope.headOuterInit = (newPost, entity) ->
      # newPost = entity.newPost
      newPost.type = 'Post'
      # alert JSON.stringify AuthService.currentUser
      # newPost.selected = AuthService.currentEntitySelection.selected
      # newPost.selectedEntity =  AuthService.currentEntitySelection.selected.id
      # newPost.entity_type = AuthService.currentEntitySelection.selected.type
      # newPost.entity_id = AuthService.currentEntitySelection.selected.id
      # newPost.entity_type = AuthService.currentEntitySelection.selected.type

    $scope.commentHeadOuterInit = (newPost, entity) ->
      # newPost = entity.newPost
      newPost.type = 'Response'
      newPost.parent_id = entity.id
      # newPost.entity_id = AuthService.currentEntitySelection.selected.id
      # newPost.entity_type = AuthService.currentEntitySelection.selected.type

    $scope.sendPost = (post)->
      entityAttrs = 
          entity_id: AuthService.currentEntitySelection.selected.id
          entity_type: AuthService.currentEntitySelection.selected.type

      post = angular.extend({}, post, entityAttrs)
      Restangular.all('me/posts').post(post).then (response)->
        # $scope.posts = $scope.posts.concat(response)
        AuthService.currentUser.posts().then (posts) ->
          # console.log "POSTS: " + JSON.stringify posts

          $scope.posts = posts
      # Restangular.all('me/posts').post(post)

    $scope.$watch 'posts', ->
      $scope.buildPostDisplay()

    $scope.$watch 'AuthService.currentUser', ->
      if AuthService.currentUser
        # $scope.displayList = []
        $scope.buildAssociationCache().then () ->
          AuthService.currentUser.posts().then (posts) ->
            # alert JSON.stringify posts

            # Cache.cache.put(post.id, post);
            $scope.posts = posts
    
    $scope.buildAssociationCache = ->
      deferred = $q.defer();
      # alert JSON.stringify  AuthService.currentUser.user_post_associations
      Restangular.several('users', AuthService.currentUser.user_post_associations).getList().then (asses)->
        for ass in asses
          # alert JSON.stringify ass
          UsersCache.cache.put(ass.id, ass)

        Restangular.several('businesses', AuthService.currentUser.business_post_associations).getList().then (asses)->
          for ass in asses
            # alert JSON.stringify ass
            BusinessesCache.cache.put(ass.id, ass)
          deferred.resolve(asses)
      

      return deferred.promise

    $scope.buildPostDisplay = ->

      if $scope.posts
        $scope.displayList = []
        for post in $scope.posts
          do (post) ->
            # alert post.entity() + " XXX " + JSON.stringify post
            post.entity().then (e)->
              post.responses().then (responses) ->
                responseList = []

                for response in responses
                  do (response) ->
                    response.entity().then (rE) ->
                      responseList.push
                        id: response.id
                        newPost: {}
                        parentId: response.parent_id
                        name: rE.name
                        # distance: entity.distance
                        added: response.created_at
                        thumb: rE.thumb
                        content: response.content
                        profile: rE.uri
                        type: response.type
                        entityType: rE.type
              # key = Object.keys(e)[0];
                entity = e
                
                $scope.displayList.push
                  id: post.id
                  newPost: {}
                  parentId: null
                  name: entity.name
                  responses: responseList
                  # distance: entity.distance
                  added: post.created_at
                  thumb: entity.thumb
                  content: post.content
                  profile: entity.uri
                  type: post.type
                  entityType: entity.type
]