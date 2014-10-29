angular.module("NM").factory "Response", [
  "$q"
  "Restangular"
  ($q, Restangular) ->
    Restangular.extendModel "me/responses", (model) ->
      model.entity = ->
        if model.user_id
          Restangular.one("users", model.user_id).get()
        else if model.business_id
          Restangular.one("businesses", model.business_id).get()

      model.parent = ->
        Restangular.one("me/posts", model.post_id)

      model.responses = ->
        if model.response_ids.length > 1
          Restangular.several("me/responses", model.response_ids)
        else $q.when([])

      return model
      # model.messages = ->
      #   Restangular.several("messages", model.user.sent_message_ids).getList()

]