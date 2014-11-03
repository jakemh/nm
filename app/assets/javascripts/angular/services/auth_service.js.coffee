App.factory "AuthService", [
  "Restangular"
  (Restangular) ->
    currentUser: null
    userBusinesses: []
    currentEntitySelection: {}
    # entityOptions: []
    entityOptions: []
    currentFollowers: []
    user: () ->
      Restangular.one('users', "current").get()


    followerUri: (other)->
      cur =  @currentEntitySelection.selected
      if cur != other
        
      else 
        null

    followerHandle: (entity, callback)->
      followerType = entity.followerUriType
      cur =  @currentEntitySelection.selected
      params = 
        connect_to_id: entity.id
        type: entity.entityType

      debugger
      if followerType == "Follow"
        cur.post('followers', params).then ()->
          callback()
          
      else if followerType == "Remove"
        cur.delete('followers', params).then ()->
          callback()



    followerType: (entity) ->
      followStatus = entity.follower_uri_type
      if followStatus == 0
        null
      else if followStatus == 1
        "Follow"
      else if followStatus == -1
        "Remove "

      # cur =  @currentEntitySelection.selected
      # if other != cur
      #   if cur.type == "User" && other.type == "Business"
      #     "Business Connection"
      #   else if cur.type == "User" && other.type == "User"
      #     "User Friendship"
      #   else if cur.type == "Business" && other.type == "Business"
      #     "Business Friendship"
      #   else if cur.type == "Business" && other.type == "User"
      #     "Business Connection"
      # else "Yours"
]
