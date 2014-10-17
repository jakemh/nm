window.App = angular.module("NM", [
  "ngRoute"
  "templates"
  "rails"
]).config ($routeProvider, $locationProvider) ->
  $routeProvider.when "/",
    templateUrl: "home.html"
    controller: "HomeCtrl"

  $locationProvider.html5Mode true
  return

  $(document).on('ready page:load', ->
    angular.bootstrap(document, ['YourApplication'])
  )