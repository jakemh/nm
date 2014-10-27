angular.module("NM").factory "Message", [
  "Restangular"
  (Restangular) ->
    Restangular.extendModel "me/messages", (model) ->
      
      model.entity = ->
        if model.user_id
          Restangular.one("users", model.user_id).get()
        else if model.business_id
          Restangular.one("businesses", model.business_id).get()

      return model

    # return Message
]