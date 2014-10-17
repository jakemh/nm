angular.module("NM").factory "Post", [
  "railsResourceFactory"
  (railsResourceFactory) ->
    return railsResourceFactory(
      url: "/posts"
      name: "post"
      
    )
]