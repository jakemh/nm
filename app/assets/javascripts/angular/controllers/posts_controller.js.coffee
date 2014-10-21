angular.module("NM").controller "PostController", [
  "$scope"
  "Post"
  ($scope, Post) ->
    $scope.posts = []
    $scope.searching = []


    $scope.addPost = (data) ->
      new Post(
        content: data.content
      ).create()
    #$scope.searching = true
    #$scope.books = []
    #
    # Find all books matching the title
    Post.query().then ((results) ->
      $scope.posts = results
      # alert JSON.stringify results
      $scope.searching = false
      return
    ), (error) ->
      
      $scope.searching = false
      return
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