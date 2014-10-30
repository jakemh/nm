angular.module("NM").factory "Post", [
  "$q"
  "UsersCache"
  "BusinessesCache"
  "Restangular"
  ($q, UsersCache, BusinessesCache, Restangular) ->
    Restangular.extendModel "me/posts", (model) ->
      model.entity = ->
        if model.user_id
          cached = UsersCache.cache.get(model.user_id)
          if !cached
            alert "NOT CACHED: " + JSON.stringify model
            Restangular.one("users", model.user_id).get()
          else 
            # alert "CACHED"
            $q.when(cached)
        else if model.business_id
          cached = BusinessesCache.cache.get(model.business_id)
          if !cached
            Restangular.one("businesses", model.business_id).get()
          else 
            $q.when(cached)

      model.responses = ->
        if model.response_ids.length > 0
          Restangular.several("me/responses", model.response_ids).getList()
        else $q.when([])

      return model
      # model.messages = ->
      #   Restangular.several("messages", model.user.sent_message_ids).getList()

]