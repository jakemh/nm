angular.module("NM").controller "AudienceController", [
  "$scope"
  "Follower"
  "User"
  "Business"
  ($scope, Follower, User, Business) ->
    Follower.query().then ((results) ->
      $scope.followers = results
      $scope.users = []
      $scope.businesses = []
      $scope.displayList = []
      $scope.updateEntities = ->
        $scope.users = []
        $scope.businesses = []

        for result in $scope.followers
          if result.entityType == "User"
            User.get({id: result.userId}).then (u)->
              $scope.users.push(u)
          else if result.entityType == "Business"
            Business.get({id: result.businessId}).then (b)->
              $scope.businesses.push(b)

      $scope.$watch 'followers', ->
        $scope.updateEntities()

      $scope.$watch 'businesses + users', ->
        $scope.displayList = []
        $scope.displayList = $scope.displayList.concat($scope.businesses)
        $scope.displayList = $scope.displayList.concat($scope.users)

      # $scope.watch "users + business"
      $scope.searching = false
      return
    ), (error) ->
      
      $scope.searching = false
]

