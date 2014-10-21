angular.module("NM").factory "Follower", [
  "railsResourceFactory"
  (railsResourceFactory) ->
    return railsResourceFactory(
      url: "/followers"
      name: "follower"
      
    )
]