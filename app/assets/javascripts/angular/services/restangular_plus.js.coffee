
App.factory "RestangularPlus", [
  "$q"
  "Restangular"
  ($q, Restangular) ->
    
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

    severalPlus: (args) ->
      @before(@checkIds, Restangular.several)(arguments[0], arguments[1])

    getListPlus: () ->
      @before(@trueTest, @getList)(arguments[0], arguments[1])
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