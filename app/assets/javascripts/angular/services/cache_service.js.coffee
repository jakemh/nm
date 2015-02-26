App.factory "CacheService", [
  "$cacheFactory"
  "$q"
  "UsersCache"
  "MessagesCache"
  "SentMessagesCache"
  "ReceivedMessagesCache"
  "FollowersCache"
  "FollowingCache"
  "BusinessesCache"
  "ReviewsCache"
  "BranchesCache"
  "AffiliationsCache"
  "Restangular"
  
  ($cacheFactory, $q, UsersCache, MessagesCache, SentMessagesCache, ReceivedMessagesCache, BusinessesCache, FollowingCache, FollowersCache, ReviewsCache, BranchesCache, AffiliationsCache, Restangular) ->

    modelsToCache: ->
      users: UsersCache
      businesses: BusinessesCache
      followers: FollowersCache
      following: FollowingCache
      # posts: PostsCache
      branches: BranchesCache
      affiliations: AffiliationsCache
      reviews: ReviewsCache
      received_messages: ReceivedMessagesCache
      posts: MessagesCache

      sent_messages: SentMessagesCache
      messages: MessagesCache

    cacheModelForList: (model, list, params)->
      deferred = $q.defer();
      if list.length > 0
        Restangular.several(model, _.uniq(list)).getList(params).then (asses)=>
          for ass in asses
            # alert JSON.stringify @modelsToCache()

            @modelsToCache()[model].cache.put(ass.id, ass)

          deferred.resolve(asses)
      else deferred.resolve(null)
      return deferred.promise

    cacheUsersForList: (list, params)->
      deferred = $q.defer();
      @cacheModelForList("users", _.uniq(source), params).then (cached)->
        deferred.resolve(cached)

      return deferred.promise

    cacheBusinessesForList: (list, params)->
      deferred = $q.defer();
      @cacheModelForList("businesses", _.uniq(source), params).then (cached)->
        deferred.resolve(cached)
      return deferred.promise

    cacheModelsForLists: (hash, params)->
      models = Object.keys(hash);
      promises = []

      for model in models

        list = hash[model]
        promises.push(@cacheModelForList(model, _.uniq(list), params))

      return $q.all(promises)

]
