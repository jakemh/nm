angular.module("NM").factory "User", [
  "railsResourceFactory"
  (railsResourceFactory) ->
    return railsResourceFactory(
      url: "/users"
      name: "user"
      
    )
]