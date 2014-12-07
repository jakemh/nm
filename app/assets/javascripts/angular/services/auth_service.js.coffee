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
    user: () ->
      RestangularPlus.getModel("users", "current")

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


    followerHandle: (viewModel, entity, callback)->
      cur =  @currentEntitySelection.selected
      params = 
        connect_to_id: entity.id
        type: entity.type

      cur.post('followers', params).then ()->
        callback(viewModel, entity)


    followerType: (entity) ->
      followStatus = entity.follower_uri_type
      if followStatus == 0
        null
      else if followStatus == 1
        "Follow"
      else if followStatus == -1
        null
     
]
