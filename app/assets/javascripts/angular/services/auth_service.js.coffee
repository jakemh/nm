App.factory "AuthService", [
  "User"
  (User) ->
    user: () ->
      User.get({id: "current"})
]


# App.factory "AuthService", [
#   "User"
#   (User) ->
#     _currentUser = undefined
#     login: ->

#     logout: ->

#     isLoggedIn: ->

#     currentUser: ->
#       if @_currentUser
#         @_currentUser
#       else
#         User.query({id: "current"}).then (results) =>
#           @_currentUser = results[0]
#   ]


  # App.factory "AuthService", ->
  #   service = 
  #     # user: null
  #     user: () ->
  #       User.query({id: "current"})

     

  #   return service;
