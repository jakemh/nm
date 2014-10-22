angular.module("NM").factory "Follower", [
  "railsResourceFactory"
  "railsSerializer"
  (railsResourceFactory, railsSerializer) ->
    Follower = railsResourceFactory
      url: "/me/followers"
      name: "follower"
      serializer: railsSerializer ->
        @resource "user", "User"
      serializer: railsSerializer ->
        @resource "business", "Business"

    Follower.prototype.entity = ->
      @user || @business
    
    Object.defineProperty @, 'entity', 
      set: (value) ->
        
      get: -> 
        @user || @business
          
    return Follower     
]


