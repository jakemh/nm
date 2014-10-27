angular.module("NM").factory "Following", [
  "Restangular"
  (Restangular) ->
    Restangular.extendModel "following", (model) ->
  
      # model.messages = ->
      #   Restangular.several("following", model.user.sent_message_ids).getList()

      return model
]