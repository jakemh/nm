angular.module("NM").factory "Post", [
  "Restangular"
  (Restangular) ->
    Restangular.extendModel "me/posts", (model) ->
      model.entity = ->
        if model.user_id
          Restangular.one("users", model.user_id).get()
        else if model.business_id
          Restangular.one("businesses", model.business_id).get()
        else 
          alert JSON.stringify model
      model.responses = ->
        Resangular.several("me/posts", model.response_ids)

      return model
      # model.messages = ->
      #   Restangular.several("messages", model.user.sent_message_ids).getList()

]