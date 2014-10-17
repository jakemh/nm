angular.module("NM").factory "Business", [
  "railsResourceFactory"
  (railsResourceFactory) ->
    return railsResourceFactory(
      url: "/businesses"
      name: "business"
      
    )
]