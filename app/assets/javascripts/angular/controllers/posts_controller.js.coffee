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
    $scope.feedCornerPartial = "feed_body_comment.html"

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
              post.responses().then (responses) ->
                responseList = []

                for response in responses
                  do (response) ->
                    response.entity().then (rE) ->
                      responseList.push
                        id: response.id
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
                  name: entity.name
                  responses: responseList
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