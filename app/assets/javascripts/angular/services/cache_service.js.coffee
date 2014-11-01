App.factory "CacheService", [
  "$cacheFactory"
  "$q"
  "UsersCache"
  "BusinessesCache"
  "Restangular"
  ($cacheFactory, $q, UsersCache, BusinessesCache, Restangular) ->

    modelsToCache: ->
      users: UsersCache
      businesses: BusinessesCache
      # posts: PostsCache
      # messages: MessagesCache

    cacheModelForList: (model, list)->
      deferred = $q.defer();
      Restangular.several(model, list).getList().then (asses)=>
        for ass in asses
          # alert JSON.stringify @modelsToCache()

          @modelsToCache()[model].cache.put(ass.id, ass)

        deferred.resolve(asses)

      return deferred.promise

    cacheUsersForList: (list)->
      deferred = $q.defer();
      @cacheModelForList("users", source).then (cached)->
        deferred.resolve(cached)

      return deferred.promise

    cacheBusinessesForList: (list)->
      deferred = $q.defer();
      @cacheModelForList("businesses", source).then (cached)->
        deferred.resolve(cached)
      return deferred.promise

    cacheModelsForLists: (hash)->
      models = Object.keys(hash);
      promises = []

      for model in models

        list = hash[model]
        promises.push(@cacheModelForList(model, list))

      return $q.all(promises)

]
