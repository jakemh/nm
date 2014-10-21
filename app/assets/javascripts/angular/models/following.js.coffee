angular.module("NM").factory "Following", [
  "railsResourceFactory"
  (railsResourceFactory) ->
    return railsResourceFactory(
      url: "/following"
      name: "following"
      
    )
]