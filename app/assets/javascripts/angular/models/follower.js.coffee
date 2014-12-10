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