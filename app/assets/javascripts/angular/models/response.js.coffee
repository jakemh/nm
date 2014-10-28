angular.module("NM").factory "Response", [
  "Restangular"
  (Restangular) ->
    Restangular.extendModel "me/posts", (model) ->
      model.entity = ->
        if model.user_id
          Restangular.one("users", model.user_id).get()
        else if model.business_id
          Restangular.one("businesses", model.business_id).get()

      model.responses = ->
        if model.response_ids.length > 1
          Restangular.several("me/responses", model.response_ids)
        else $q.when([])

      return model
      # model.messages = ->
      #   Restangular.several("messages", model.user.sent_message_ids).getList()

]