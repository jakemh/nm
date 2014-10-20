window.App = angular.module("NM", [
  "ngRoute"
  "templates"
  "rails"
]).config ($routeProvider, $locationProvider) ->
  $routeProvider.when "/",
    templateUrl: "home.html"
    controller: "HomeCtrl"

  .when "/businesses",
    templateUrl: "alphaBusiness.html"
    controller: "BusinessDirectoryController"

  $locationProvider.html5Mode true
  return

  $(document).on('ready page:load', ->
    angular.bootstrap(document, ['NM'])
  )

  # phonecatApp.config [
  #   "$routeProvider"
  #   ($routeProvider) ->
  #     $routeProvider.when("/phones",
  #       templateUrl: "partials/phone-list.html"
  #       controller: "PhoneListCtrl"
  #     ).when("/phones/:phoneId",
  #       templateUrl: "partials/phone-detail.html"
  #       controller: "PhoneDetailCtrl"
  #     ).otherwise redirectTo: "/phones"
  # ]