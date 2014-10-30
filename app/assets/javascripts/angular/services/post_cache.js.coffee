App.factory "PostsCache", [
  "$cacheFactory"
  "Restangular"
  ($cacheFactory, Restangular) ->
    cache: $cacheFactory('me/posts');


]

App.factory "UsersCache", [
  "$cacheFactory"
  "Restangular"
  ($cacheFactory, Restangular) ->
    cache: $cacheFactory('users');
    

]

App.factory "BusinessesCache", [
  "$cacheFactory"
  "Restangular"
  ($cacheFactory, Restangular) ->
    cache: $cacheFactory('businesses');
    

]
