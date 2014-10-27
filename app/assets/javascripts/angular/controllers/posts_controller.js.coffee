angular.module("NM").controller "PostController", [
  "$scope"
  "Utilities"
  "Restangular"
  "AuthService"
  ($scope,  Utilities, Restangular, AuthService) ->
    $scope.posts = []
    $scope.displayList = []
    $scope.searching = []
    $scope.AuthService = AuthService
    $scope.Utilities = Utilities
    $scope.feedHeadBody = "feed_head_form.html"
    $scope.newPost = {}
    # Restangular.all('me/posts').post({content: "XYZ"})

    $scope.sendPost = (post)->
      Restangular.all('me/posts').post(post).then (response)->
        $scope.posts = $scope.posts.concat(response)
      # Restangular.all('me/posts').post(post)
    $scope.$watch 'posts', ->

      if $scope.posts
        $scope.displayList = []
        for post in $scope.posts
          do (post) ->
            # alert post.entity() + " XXX " + JSON.stringify post
            post.entity().then (e)->
              key = Object.keys(e)[0];
              entity = e[key]
              
              $scope.displayList.push
                id: post.id
                name: entity.name
                # distance: entity.distance
                added: post.created_at
                thumb: entity.thumb
                content: post.content
                profile: entity.uri
                type: post.type
                entityType: entity.type

    $scope.$watch 'AuthService.currentEntitySelection.selected', ->
      if AuthService.currentUser
        # $scope.displayList = []
        AuthService.currentUser.posts().then (posts) ->
          # alert JSON.stringify posts

          $scope.posts = posts
          

]