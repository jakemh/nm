angular.module("NM").controller "AudienceController", [
  "$scope"
  "$sce"
  "Follower"
  "User"
  "Business"
  "Entity"
  "AuthService"
  ($scope, $sce, Follower, User, Business, Entity, AuthService) ->
    $scope.init = () ->
      AuthService.user().then (user)->
        $scope.currentUser = user

    $scope.init()
    $scope.trustAsHtml = (value)-> 
      return $sce.trustAsHtml(value);

    # alert JSON.stringify AuthService.data()
    

    
    # $scope.currentUser = AuthService.user

    $scope.$watch 'currentUser', ->
      if $scope.currentUser
        $scope.userBusinesses = $scope.currentUser.businesses
        # $scope.$apply()

    $scope.$watch 'userBusinesses', ->
      if $scope.currentUser
        $scope.entityOptions = _.map [$scope.currentUser].concat($scope.userBusinesses), (item, i) ->
          name: item.name
          thumb: item.thumb
          id: i
        $scope.currentEntity.selected = $scope.entityOptions[0]

    $scope.followers = []
    $scope.currentUser = null
    $scope.userBusinesses = null
    $scope.currentEntity = {}
    $scope.entityOptions = null
    $scope.displayList = []
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
      
    Follower.query({distance: true}).then ((results) ->
      $scope.followers = results
   
       
      # $scope.watch "users + business"
      $scope.searching = false
      return
    ), (error) ->
      
      $scope.searching = false

    
]

