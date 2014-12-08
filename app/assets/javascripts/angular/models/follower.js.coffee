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
  "$q"
  "Restangular"
  "RestangularPlus"
  ($q, Restangular, RestangularPlus) ->
    Restangular.extendModel "followers", (model) ->
  
     model.entity = ->
       if model.user_id
         RestangularPlus.getModel("users", model.user_id)
       else if model.business_id
         RestangularPlus.getModel("businesses", model.business_id)

      return model
]