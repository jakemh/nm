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



]
