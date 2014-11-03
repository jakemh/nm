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

    followerHandle: (entity)->
      cur =  @currentEntitySelection.selected
      cur.post 'followers',
        connect_to_id: entity.id
        type: entity.entityType


    followerType: (other) ->
      cur =  @currentEntitySelection.selected
      if other != cur
        if cur.type == "User" && other.type == "Business"
          "Business Connection"
        else if cur.type == "User" && other.type == "User"
          "User Friendship"
        else if cur.type == "Business" && other.type == "Business"
          "Business Friendship"
        else if cur.type == "Business" && other.type == "User"
          "Business Connection"
      else "Yours"
]
