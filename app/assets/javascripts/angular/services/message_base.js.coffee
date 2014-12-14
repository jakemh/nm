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
      
      if @user_id
        RestangularPlus.getModel('users', @user_id, params)
      else if @business_id
        RestangularPlus.getModel('businesses', @business_id, params)

    fromEntity: (params) ->
      @entity(params)

    toEntity: (params) ->
      if @to_entity_type == "User"
        RestangularPlus.getModel('users', @to_entity_id, params)
      else if @to_entity_type == "Business"
        RestangularPlus.getModel('businesses', @to_entity_id, params)

    responses: (model, params) ->
      if model.response_ids.length > 0
        Restangular.several("me/responses", model.response_ids).getList(params)
      else $q.when([])

]
