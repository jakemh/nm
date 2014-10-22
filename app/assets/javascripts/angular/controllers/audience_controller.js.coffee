# app.factory('UserService', function() {
#   return {
#       user: 
#   };
# });

angular.module("NM").controller "AudienceController", [
  "$scope"
  "Follower"
  "User"
  "Business"
  "Entity"
  ($scope, Follower, User, Business, Entity) ->

    $scope.followers = []
    # $scope.users = []
    # $scope.businesses = []
    # $scope.entities = []

    $scope.displayList = []
    # $scope.hash = {}
    $scope.sortOptions = [
      {name: "added", id: 1}
      {name: "distance", id: 2}
      {name: "name", id: 3}

    ]
    # $scope.sortVal = $scope.sortOptions[0]
    $scope.sortVal = {}
    $scope.$watch 'followers', ->
      $scope.displayList = _.map $scope.followers, (item)-> 
        name: item.entity().name
        distance: item.entity().distance
        added: item.createdAt
      
      alert JSON.stringify $scope.displayList

    Follower.query({distance: true}).then ((results) ->
      $scope.followers = results
      # alert JSON.stringify results[0].entity()
      # alert JSON.stringify results[0].user
      # alert JSON.stringify results
      

      # $scope.$watch 'sortVal', ->
      #   $scope.sort = $scope.sortVal.name
      #   alert JSON.stringify $scope.sortVal
        # alert JSON.stringify $scope.displayList
      #   # alert JSON.stringify $scope.hash
      #   _.sortBy $scope.displayList, (item) ->
          # alert item.
          # alert JSON.stringify $scope.hash[item.toString()]
          # connection = $scope.followers[]]
          # alert JSON.stringify connection
     


      
        
       
        
      # $scope.watch "users + business"
      $scope.searching = false
      return
    ), (error) ->
      
      $scope.searching = false
]

