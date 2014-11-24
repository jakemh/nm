angular.module("NM").factory "Response", [
  "$q"
  "UsersCache"
  "BusinessesCache"
  "Restangular"
  ($q, UsersCache, BusinessesCache, Restangular) ->
    Restangular.extendModel "me/responses", (model) ->
      
      model.entity = ->
        if model.user_id
          cached = UsersCache.cache.get(model.user_id)
          if !cached
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

      return model
      # model.messages = ->
      #   Restangular.several("messages", model.user.sent_message_ids).getList()

]