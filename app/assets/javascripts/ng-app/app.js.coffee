angular.module("NM", [
  "ngRoute"
  "templates"
]).config ($routeProvider, $locationProvider) ->
  $routeProvider.when "/",
    templateUrl: "home.html"
    controller: "HomeCtrl"

  $locationProvider.html5Mode true
  return
