

angular.module("NM").controller "AudienceController", [
  "$scope"
  "$q"
  "Utilities"
  "Restangular"
  "AuthService"
  "SideBar"
  "entityHash"
  ($scope, $q, Utilities, Restangular, AuthService, SideBar, entityHash) ->

    $scope.current = AuthService.currentEntitySelection.selected
    $scope.entityHash = entityHash
    $scope.currentDisplayEntity = () ->
      entityHash($scope.current)

    $scope.Utilities = Utilities
    $scope.feedContentPartial = "feed_body_audience.html"
    $scope.AuthService = AuthService
    $scope.SideBar = SideBar
    $scope.followersList = []
    $scope.followingList = []
    
    $scope.followersDisplay = []
    $scope.followingDisplay = []

    $scope.displayList = []
    # SideBar.rightBarTemplate = "right_bar_business.html"        
    SideBar.rightBarTemplate = "blank.html"  


    # $scope.loadMap()
    SideBar.tabBarVisible = true 

    
    $scope.followerFilter = true
    $scope.followingFilter = false
    # $scope.interactions = {data: null, labels: null}
    

    $scope.$watch "AuthService.currentEntitySelection.selected", ->
      AuthService.currentEntitySelection.selected.all("interactions").getList().then (i) ->
        list = i[0]
        dates = _.map list.dates, (item) -> moment(item).format("LL")
        interactions = list.interactions
        $scope.chart.labels = dates
        $scope.chart.datasets[0].data = interactions
        
      ent = AuthService.currentEntitySelection.selected
      $scope.getFollowing(ent)
      $scope.getFollowers(ent)

    $scope.chart = {
        # labels : ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
        labels: []
        datasets : [
            {
                fillColor : "rgba(151,187,205,0)",
                strokeColor : "#e67e22",
                pointColor : "rgba(151,187,205,0)",
                pointStrokeColor : "#e67e22",
                data : []
                # data: []
            }
      
        ], 
    };

    $scope.init = () ->
      ent = AuthService.currentEntitySelection.selected
      # $scope.currentDisplayEntity()
      
        
      # $scope.getFollowing(ent)
      # $scope.getFollowers(ent)

    $scope.getFollowers = (ent)->
      ent.getFollowers().then (followers)->
        $scope.current.followers = followers

    $scope.getFollowing = (ent)->
      ent.getFollowing().then (following)->
        $scope.current.following = following

    $scope.audMemberClass = (index)->
      if index % 2 == 0
        return "aud__member--left" 
      else return "aud__member--right"

    
      # $scope.followersDisplayList.concat($scope.followingDisplayList)

    # $scope.$watch 'followerDisplay + followingDisplay', ->
    #   $scope.displayList = $scope.followersDisplay.concat($scope.followingDisplay)

    $scope.sortOptions = [
      {name: "added", id: 1, attr: "added"}
      {name: "distance", id: 2, attr: "distance"}
      {name: "name", id: 3, attr: "name"}
      {name: "total interactions", id: 4, attr: "interactions", reverse: true}
      {name: "interactions to you", id: 5, attr: "interactionsIn", reverse: true}



    ]
    
    $scope.filterOptions = [
      {name: "Show All", id: 0, group: "Main"}
      {name: "Businesses Only", id: 1, group: "Main"}
      # {name: "Industry1", id: 2, group: "Industry"}
      # {name: "Industry2", id: 2, group: "Industry"}
      # {name: "Industry3", id: 2, group: "Industry"}
      # {name: "Industry4", id: 2, group: "Industry"}

      # {name: "Type1", id: 3, group: "Type"}
      # {name: "Type2", id: 3, group: "Type"}
      # {name: "Type3", id: 3, group: "Type"}
      # {name: "Type4", id: 3, group: "Type"}
    ]

    $scope.filterGroup = (item)->
      return item.group

    # $scope.sortVal = $scope.sortOptions[0]
    $scope.sortVal = {}
    $scope.filterVal = {}
    $scope.filterVal.selected = $scope.filterOptions[0]

    $scope.displayHash = (entity, f, aes) ->
      models: {entity: entity, connection: f}
      name: entity.name
      associatedEntities: aes
      distance: entity.distance
      added: f.created_at
      thumb: entity.thumb
      profile: entity.uri
      type: f.type
      entityType: entity.type
      interactions: f.getInteractions()
      interactionsIn: f.getInteractionsIn() || 0

      isFollower: -> _.contains this.relationships, "Follower"
      isFollowing: -> _.contains this.relationships, "Following"

    $scope.$watch 'current.followers', ->
        # $q.all(AuthService.currentFollowers)
      $scope.currentDisplayEntity().followersDisplay = []
      for f in $scope.current.followers
        do (f) -> 
          f.entity()
            .then (e) ->
              entity = e

              e.associatedEntities().then (aes) ->
                $scope.currentDisplayEntity().followersDisplay.push(
                  angular.extend $scope.displayHash(e, f, aes), 
                    relationships: ["Follower"]
                )
   
    $scope.$watch 'currentDisplayEntity().followingDisplay.length + currentDisplayEntity().followersDisplay.length', ->
      # alert $scope.currentDisplayEntity().followingDisplay.length + " " + $scope.currentDisplayEntity().followersDisplay.length
      $scope.currentDisplayEntity().buildAllConnections()
    

    $scope.$watch 'current.following', ->
      # $q.all(AuthService.currentFollowers)
      $scope.currentDisplayEntity().followingDisplay = []
      
      for f in $scope.current.following
        do (f) -> 
          f.entity().then (e) ->
            entity = e

            e.associatedEntities().then (aes) ->

              $scope.currentDisplayEntity().followingDisplay.push(
                angular.extend $scope.displayHash(e, f, aes), 
                  relationships: ["Following"]
              )
]


angular.module("NM").filter "audienceTypeFilter", ->
  (displayEntities, currentEntity, followerFilter, followingFilter) ->
    if displayEntities
      displayEntities.filter (displayEntity) ->

        if followerFilter
          # bool =  _.contains displayEntity.relationships, "Follower"
          # displayEntity.relationships.push "Follower"
          return true if displayEntity.isFollower()

        if followingFilter
          # bool =  _.contains displayEntity.relationships, "Following"

          # console.log ["FOLLOWING", bool, connection.id, JSON.stringify currentEntity.following_ids]
          # displayEntity.relationships.push "Following"
          return true if displayEntity.isFollowing()


        return false

App.filter "slice", ->
  (arr, start, end) ->
    (arr or []).slice start, end


angular.module("NM").filter "userBusinessFilter", ->
  (entities, filterVal) ->
    if entities
      entities.filter (entity) ->

        if filterVal

          if filterVal.name == "Businesses Only"
            # alert JSON.stringify entity
            return false if entity.entityType != "Business"
            return true
        return true
      # entities.filter (entity) ->
      #   return personFilter if entity.type == "User"
      #   return businessFilter if entity.type == "Business"
