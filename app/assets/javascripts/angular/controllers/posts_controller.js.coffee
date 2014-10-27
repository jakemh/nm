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

    # $scope.addPost = (data) ->
    #   new Post(
    #     content: data.content
    #   ).create()

    $scope.$watch 'AuthService.currentEntitySelection.selected', ->
      if AuthService.currentUser
        $scope.displayList = []
        AuthService.currentUser.posts().then (posts) ->
          $scope.posts = posts
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

    #$scope.searching = true
    #$scope.books = []
    #
    # Find all books matching the title
    # Post.query().then ((results) ->
    #   $scope.posts = results
    #   # alert JSON.stringify results
    #   $scope.searching = false
    #   return
    # ), (error) ->
      
    #   $scope.searching = false
    #   return
#
    #
     #Find a single book and update it
    #Book.get(1234).then (book) ->
      #book.lastViewed = new Date()
      #book.update()
      #return
#
    #
     # Create a book and save it
    #new Book(
      #title: "Gardens of the Moon"
      #author: "Steven Erikson"
      #isbn: "0-553-81957-7"
    #).create()
]