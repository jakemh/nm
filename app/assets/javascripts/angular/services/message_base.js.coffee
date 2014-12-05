App.factory "MessageBase", [
  "$q"
  "UsersCache"
  "BusinessesCache"
  "Restangular"
  "RestangularPlus"
  ($q, UsersCache, BusinessesCache, Restangular, RestangularPlus) ->

    entity: (params) ->
      
      # if model.user_id
      #   cached = UsersCache.cache.get(model.user_id)
      #   if !cached
      #     # alert "NOT CACHED: " + JSON.stringify model
      #     Restangular.one("users", model.user_id).get(params)
      #   else 
      #     # alert "CACHED"
      #     $q.when(cached)
      # else if model.business_id
      #   cached = BusinessesCache.cache.get(model.business_id)
      #   if !cached
      #     Restangular.one("businesses", model.business_id).get(params)
      #   else 
      #     $q.when(cached)
      
      if this.user_id
        RestangularPlus.getModel('users', this.user_id, params)
      else if this.business_id
        RestangularPlus.getModel('businesses', this.business_id, params)

    responses: (model, params) ->
      if model.response_ids.length > 0
        Restangular.several("me/responses", model.response_ids).getList(params)
      else $q.when([])

]
