
App.factory "CacheBase", [
  () ->
    modelsToCache: ->
      users: UsersCache
      businesses: BusinessesCache

]

