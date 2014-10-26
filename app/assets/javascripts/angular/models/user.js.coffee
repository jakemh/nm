angular.module("NM").factory "User", [
  "railsResourceFactory"
  "railsSerializer"

  (railsResourceFactory, railsSerializer) ->
    return railsResourceFactory(
      url: "/users"
      name: "user"
      
      serializer: railsSerializer ->
        @resource "followers", "Follower"
      serializer: railsSerializer ->
        @resource "followers", "Follower"
      serializer: railsSerializer ->
        @resource "businesses", "Business"
      serializer: railsSerializer ->
        @resource "messages", "Message"
    )
]