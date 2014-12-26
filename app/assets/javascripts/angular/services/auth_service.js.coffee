

App.factory "AuthService", [
  "$q"
  "RestangularPlus"

  ($q, RestangularPlus) ->
    currentUser: null
    userBusinesses: []
    currentEntitySelection: {}
    # entityOptions: []
    # rightBarTemplate: "blank.html"

    entityOptions: []
    currentFollowers: []


    # selected: @currentEntitySelection.selected
    currentId: () ->
      if @currentEntitySelection.selected.type == "Business"
        {business_id: @currentEntitySelection.selected.id}
      else if @currentEntitySelection.selected.type == "User"
        {user_id: @currentEntitySelection.selected.id}
        


    user: () ->
      if !@currentUser
        RestangularPlus.getModel("users", "current")
      else $q.when(@currentUser)

    isFollowing: (entity, selectedEntity) ->
      if entity.type == "Business"

        if _.contains(selectedEntity.business_ids, entity.id)
          return null # "YOU OWN THIS!!"
        else if entity == selectedEntity 
          return null #  "YOU!!"
        else if _.contains(selectedEntity.business_connection_ids, entity.id)
          return null #  "FOLLOWING"
        else return "FOLLOW"

      else if entity.type == "User"
        if entity == selectedEntity 
          return null #  "YOU!!"

        else if _.contains(selectedEntity.user_connection_ids, entity.id)
          return null #  "FOLLOWING"
        else if selectedEntity.owner_id == entity.id 
          return null #  "YOUR OWNER"
        else return "FOLLOW"

    followerUri: (other)->
      cur = entity.currentEntitySelection.selected
      if cur != other
        
      else 
        null

    entityHash: (DisplayModel) ->
      deferred = $q.defer();

      @user()
        .then (user)->
          return user.ownedEntities()
        .then (entities) ->
          hash = {}

          for entity in entities
            key = [entity.type, entity.id]

            hash[key] = new DisplayModel(entity)

          deferred.resolve (entity) ->
            key = [entity.type, entity.id]
            return hash[key]

      return deferred.promise
      
    messageFollowerHandle: (viewModel, entity, callback)->
      @followerHandle(entity).then ()->
        callback(viewModel, entity)

    profileFollowerHandle: (entity, callback)->
      @followerHandle(entity).then ()->
        callback(entity, callback)
        
    followerHandle: (entity)->
      deferred = $q.defer();

      cur =  @currentEntitySelection.selected
      params = 
        connect_to_id: entity.id
        type: entity.type

      cur.post('followers', params).then (response)->
        entity.follower_count += 1
        deferred.resolve(response)

      return deferred.promise

  

    followerType: (entity) ->
      followStatus = entity.follower_uri_type
      if followStatus == 0
        null
      else if followStatus == 1
        "Follow"
      else if followStatus == -1
        null
     
]
