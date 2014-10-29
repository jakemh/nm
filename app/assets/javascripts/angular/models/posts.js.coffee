angular.module("NM").factory "Post", [
  "$q"
  "Restangular"
  ($q, Restangular) ->
    Restangular.extendModel "me/posts", (model) ->
      model.entity = ->
        if model.user_id
          Restangular.one("users", model.user_id).get()
        else if model.business_id
          Restangular.one("businesses", model.business_id).get()
        # else 
        #   alert JSON.stringify model
      model.responses = ->
        if model.response_ids.length > 0
          Restangular.several("me/responses", model.response_ids).getList()
        else $q.when([])

      return model
      # model.messages = ->
      #   Restangular.several("messages", model.user.sent_message_ids).getList()

]