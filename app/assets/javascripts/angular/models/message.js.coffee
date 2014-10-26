# angular.module("NM").factory "Message", [
#   "railsResourceFactory"
#   (railsResourceFactory) ->
#     return railsResourceFactory(
#       url: "/messages"
#       name: "message"
      
#     )
# ]

angular.module("NM").factory "Message",
  ($resource) ->
    $resource "/messages" # Note the full endpoint address