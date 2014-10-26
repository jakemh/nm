App.factory "AuthService", [
  "User"
  (User) ->
    currentUser: null
    userBusinesses: []
    currentEntitySelection: {}
    # entityOptions: []
    entityOptions: []
    currentFollowers: []
    user: () ->
      User.get({id: "current"})



]
