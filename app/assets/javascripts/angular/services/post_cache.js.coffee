App.factory "PostsCache", [
  "$cacheFactory"
  "Restangular"
  ($cacheFactory, Restangular) ->
    cache: $cacheFactory('me/posts');


]

App.factory "BranchesCache", [
  "$cacheFactory"
  "Restangular"
  ($cacheFactory, Restangular) ->
    cache: $cacheFactory('branches');


]

App.factory "SentMessagesCache", [
  "$cacheFactory"
  "Restangular"
  ($cacheFactory, Restangular) ->
    cache: $cacheFactory('sent_messages');


]

App.factory "ReceivedMessagesCache", [
  "$cacheFactory"
  "Restangular"
  ($cacheFactory, Restangular) ->
    cache: $cacheFactory('received_messages');
]

App.factory "MessagesCache", [
  "$cacheFactory"
  "Restangular"
  ($cacheFactory, Restangular) ->
    cache: $cacheFactory('messages');


]

App.factory "UsersCache", [
  "$cacheFactory"
  "Restangular"
  ($cacheFactory, Restangular) ->
    cache: $cacheFactory('users');
]

App.factory "ReviewsCache", [
  "$cacheFactory"
  "Restangular"
  ($cacheFactory, Restangular) ->
    cache: $cacheFactory('reviews');
]

App.factory "BusinessesCache", [
  "$cacheFactory"
  "Restangular"
  ($cacheFactory, Restangular) ->
    cache: $cacheFactory('businesses');
  
]

App.factory "FollowersCache", [
  "$cacheFactory"
  "Restangular"
  ($cacheFactory, Restangular) ->
    cache: $cacheFactory('following');
    

]
App.factory "FollowingCache", [
  "$cacheFactory"
  "Restangular"
  ($cacheFactory, Restangular) ->
    cache: $cacheFactory('followers');
    

]