App.factory "RestangularPlus", [
  "$q"
  "CacheService"
  "Restangular"
  ($q, CacheService, Restangular) ->

    removeFromCache: ()->
      CacheService.modelsToCache()[this.route].cache.remove(this.id)
    
    before: (before, fn) ->
      () ->
        if before.apply(this, arguments)
          fn.apply(this, arguments)
        else 
          $q.when([])

    checkIds: (ids)->
      ids instanceof Array && ids.length > 0

    trueTest: ()->
      true


    getModel: (modelName, id, params) ->

      deferred = $q.defer();
      cache = CacheService.modelsToCache()[modelName].cache
      cachedModel = cache.get(id)

      if cachedModel
        return $q.when(cachedModel)
      else
        Restangular.one(modelName, id).get(params).then (model) ->
          cachedModel = cache.get(model.id)
          if !cachedModel
            cache.put(model.id, model)
            cachedModel = cache.get(model.id)

          deferred.resolve(cachedModel)


      return deferred.promise


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

    severalPlus: (model, idList, params) ->
      ids = angular.copy(idList);
      if ids.length > 0
        deferred = $q.defer();

        cache = CacheService.modelsToCache()[model].cache
        returnList = []

        for id, i in ids
          cachedModel = cache.get(id)

          if cachedModel
            returnList.push(cachedModel)
            ids.splice(i, 1) if (i > -1) 

        Restangular.several(model, ids).getList(params).then (list) ->

          for entity in list
            addEntity = cache.get(entity.id)
            if addEntity
              returnList.push(addEntity)
            else 
              cache.put(entity.id, entity)
              returnList.push(cache.get(entity.id))

          deferred.resolve(returnList)

        return deferred.promise
      else return $q.when([])


    # severalPlus: (args) ->
    #   @before(@trueTest, Restangular.several)(arguments[0], arguments[1])

    # getListPlus: () ->
    #   @before(@trueTest, @getList)(arguments[0], arguments[1])
    getListPlus: (model, params) ->
      deferred = $q.defer();
      cacheObject = CacheService.modelsToCache()[model]
      cache = null
      if cacheObject
        cache = CacheService.modelsToCache()[model].cache
       
      returnList = []
      @getList(model, params).then (list)->
        for entity in list
          if cache
            cachedObject = cache.get(entity.id)
            if cachedObject
              returnList.push(cachedObject)
            else
              cache.put(entity.id, entity) 
              returnList.push(cache.get(entity.id))
          else 
            returnList.push(entity)
        deferred.resolve(returnList)

      return deferred.promise

         #   
    Restangular: Restangular

    getListPlus2: (model, params) ->
      deferred = $q.defer();
      cacheObject = CacheService.modelsToCache()[model]
      cache = null
      if cacheObject
        cache = CacheService.modelsToCache()[model].cache
       
      returnList = []
      Restangular.all(model, params).getList().then (list)->
        for entity in list
          if cache
            cachedObject = cache.get(entity.id)
            if cachedObject
              returnList.push(cachedObject)
            else
              cache.put(entity.id, entity) 
              returnList.push(cache.get(entity.id))
          
        deferred.resolve(returnList)

      return deferred.promise

         #   
    Restangular: Restangular
]

# App.factory "RestangularPlus", [
#   "$q"
#   "CacheService"
#   "Restangular"
#   ($q, CacheService, Restangular) ->
#     several: (obj, route, ids) ->
#       if self.ids.length > 0
#         obj.several(route, ids)
#       else $q.when([])

#     one: (obj, route, ids) ->
#       # obj.several(route, ids)
#       cached = CacheService.modelsToCache[obh]
#       # cached = UsersCache.cache.get(model.user_id)
#       if !cached
#         # alert "NOT CACHED: " + JSON.stringify model
#         Restangular.one("users", model.user_id).get()
#       else 
#         # alert "CACHED"
#         $q.when(cached)

# ]