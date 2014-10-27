# angular.module("NM").factory "Message", [
#   "Restangular"
#   (Restangular) ->
#     Restangular.extendModel "me/messages", (model) ->
      
#       model.entity = ->
#         if model.user_id
#           Restangular.one("users", model.user_id).get()
#         else if model.business_id
#           Restangular.one("businesses", model.business_id).get()

#       return model

#     # return Message
# ]

angular.module("NM").factory "ReceivedMessage", [
  "Restangular"
  (Restangular) ->
    Restangular.extendModel "me/received_messages", (model) ->
      
      model.entity = ->
        if model.user_id
          Restangular.one("users", model.user_id).get()
        else if model.business_id
          Restangular.one("businesses", model.business_id).get()

      return model

    # return Message
]

angular.module("NM").factory "SentMessage", [
  "Restangular"
  (Restangular) ->
    Restangular.extendModel "me/sent_messages", (model) ->
      
      model.entity = ->
        if model.user_id
          Restangular.one("users", model.user_id).get()
        else if model.business_id
          Restangular.one("businesses", model.business_id).get()

      return model

    # return Message
]