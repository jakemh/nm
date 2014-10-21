angular.module("NM").factory "Follower", [
  "railsResourceFactory"
  (railsResourceFactory) ->
    return railsResourceFactory(
      url: "/me/followers"
      name: "follower"
      
    )


]