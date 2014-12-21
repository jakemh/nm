
angular.module("NM").controller "PostController", [
  "$scope"
  "$q"
  "CacheService"
  "Utilities"
  "MessagesDisplay"
  "Restangular"
  "AuthService"
  "SideBar"
  "MessageService"

  ($scope, $q, CacheService, Utilities, MessagesDisplay,  Restangular, AuthService, SideBar, MessageService) ->
    # $scope.postsCache = $cacheFactory('me/posts');
    $scope.posts = []
    $scope.allPosts = []
    $scope.MessageService = MessageService
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
    SideBar.tabBarVisible = true 
    $scope.CacheService = CacheService
    $scope.entities = $scope.displayList
    $scope.disableInfiniteLoad = true

    $scope.initialLoadPosts = () ->
      $scope.disableInfiniteLoad = true

      AuthService.currentUser.posts("all": true).then (posts) ->
        $scope.allPosts = _.sortBy(posts, (item) -> item.id).reverse()
        
        source = $scope.allPosts.slice(0, 5)
        MessagesDisplay.buildMessageDisplay2 $scope.displayList, source, {}, (i) ->
          if source.length == $scope.displayList.length
            $scope.disableInfiniteLoad = false

    $scope.loadPosts = () ->
      # $scope.disableInfiniteLoad = true
      # l = $scope.displayList.length
      # source = $scope.allPosts.slice(l, l+5)

      # MessagesDisplay.buildMessageDisplay(source).then (list)->
      #   for post in list
      #     $scope.displayList.push post

      #   $scope.disableInfiniteLoad = false


    

    $scope.headOuterInit = (newPost, entity) ->
      newPost.type = 'Post'
    
    $scope.debugClick = ()->
      # debugger
    
    $scope.commentHeadOuterInit = (newPost, entity) ->
      newPost.type = 'Response'
      newPost.parent_id = entity.id
    
    $scope.followerCallback = (viewModel, entity)->
      viewModel.followerFeedback = true
      AuthService.currentEntitySelection.selected.pushFollowing(entity)
   
      
    $scope.sendPost = (postObj, postSubmit, responseList)->
      ent = AuthService.currentEntitySelection.selected
      entityAttrs = 
          entity_id: ent.id
          entity_type: ent.type 

      postSubmit = angular.extend({}, postSubmit, entityAttrs)

      ent.post("posts", postSubmit).then (response)->

        # alert JSON.stringify response
        
        if !responseList
          formattedPost = MessagesDisplay.displayHash(response, AuthService.currentEntitySelection.selected, [])
          $scope.displayList = $scope.displayList.concat formattedPost
        else
          formattedPost = MessagesDisplay.displayHash(response, AuthService.currentEntitySelection.selected)
          responseList.push formattedPost


    

    $scope.$watch 'AuthService.currentUser', ->
      current = AuthService.currentEntitySelection.selected

      if AuthService.currentUser
      
          $scope.initialLoadPosts()
    
]