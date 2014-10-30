App.factory "MessageBase", [
  "$q"
  "UsersCache"
  "BusinessesCache"
  "Restangular"
  ($q, UsersCache, BusinessesCache, Restangular) ->

    entity: (model) ->
      if model.user_id
        cached = UsersCache.cache.get(model.user_id)
        if !cached
          # alert "NOT CACHED: " + JSON.stringify model
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

    responses: (model) ->
      if model.response_ids.length > 0
        Restangular.several("me/responses", model.response_ids).getList()
      else $q.when([])

]
