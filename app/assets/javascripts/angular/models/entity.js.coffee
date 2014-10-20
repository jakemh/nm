angular.module("NM").factory "Entity", [
  "railsResourceFactory"
  (railsResourceFactory) ->
    return railsResourceFactory(
      url: "/entities"
      name: "entity"
      
    )
]