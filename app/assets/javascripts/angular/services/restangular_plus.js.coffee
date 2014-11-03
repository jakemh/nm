# App.factory "RestangularPlus", [
#   "Restangular"
#   (Restangular) ->
#     extended = angular.extend(Restangular, {})
#     extended.method = ->
#       alert "TEST"
#     # before: (before, fn, args) ->
#     #   ->
#     #     before.apply(this, args)
#     #     fn.apply(this, args)

#     # checkIds: (ids)->
#     #   ids instanceof Array && ids.length > 0

#     # several: (args) ->
#     #   alert "TEST"
#     #   before(checkIds, Restangular.several, args)


#     return extended

# ]

App.factory "RestangularPlus", [
  "Restangular"
  (Restangular) ->
    test: -> 
      alert "TEST"

    before: (before, fn) ->
      ->
        if before.apply(this, arguments)
          fn.apply(this, arguments)
        else $q.when([])

    checkIds: (args)->
      ids instanceof Array && ids.length > 0


    severalPlus: (args) ->
      @before(@checkIds, Restangular.several)(arguments)

    getListPlus: () ->
      @before(@checkIds, this.getList)(arguments["0"])
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