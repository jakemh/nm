angular.module("NM").factory "Business", [
  "railsResourceFactory"
  "railsSerializer"
  (railsResourceFactory, railsSerializer) ->
    return railsResourceFactory(
      url: "/businesses"
      name: "business"
      serializer: railsSerializer ->
        @resource "messages", "Message"
        
    )
]