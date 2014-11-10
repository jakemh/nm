App.factory "InfiniteScdroll", [
  "MessageDisplay"
  (MessageDisplay) ->
    loadMore: ->
       # alert "TEST"
       additions = []
       # last = $scope.postIntermediate[$scope.postIntermediate.length - 1]
       # i =  $scope.postIntermediate.length  - 1
       # start = $scope.postIntermediate.length
       i = 0
       ref = $scope.postIntermediate.length
       $scope.postIntermediate = []
       while i <= (ref + 10) && i < ($scope.posts.length)
         console.log $scope.posts
         $scope.postIntermediate.push $scope.posts[i]
         i++
         # break if $scope.postIntermediate.length > 200
       
       # $scope.postIntermediate.concat additions
       # alert $scope.postIntermediate.length
       MessagesDisplay.buildMessageDisplay2($scope.displayList, $scope.postIntermediate)

       # MessagesDisplay.buildMessageDisplay(null, $scope.postIntermadiate).then (list)->
       #   $scope.displayList = list
       #   alert JSON.stringify list

    formatPosts: (posts)->
      return _.sortBy(posts, (item) -> item.created_at).reverse()
]



