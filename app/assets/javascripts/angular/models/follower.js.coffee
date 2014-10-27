# angular.module("NM").factory "Follower", [
#   "railsResourceFactory"
#   "railsSerializer"
#   (railsResourceFactory, railsSerializer) ->
#     Follower = railsResourceFactory
#       url: "/me/followers"
#       name: "follower"
#       serializer: railsSerializer ->
#         @resource "user", "User"
#       serializer: railsSerializer ->
#         @resource "business", "Business"

#     Follower.prototype.entity = ->
#       @user || @business
    
#     Object.defineProperty @, 'entity', 
#       set: (value) ->
        
#       get: -> 
#         @user || @business
          
#     return Follower     
# ]


angular.module("NM").factory "Follower", [
  "Restangular"
  (Restangular) ->
    Restangular.extendModel "me/followers", (model) ->
  
     model.entity = ->
       if model.user_id
         Restangular.one("users", model.user_id).get()
       else if model.business_id
         Restangular.one("businesses", model.business_id).get()

      return model
]