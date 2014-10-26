window.App = angular.module("NM", [
  "ngRoute"
  "templates"
  "rails"
  "ui.select"
  "ngSanitize"
  'ngResource'
]).config ($routeProvider, $locationProvider) ->


  $routeProvider.when "/",
    templateUrl: "home.html"
    controller: "HomeCtrl"

  .when "/businesses",
    templateUrl: "alphaBusiness.html"
    controller: "BusinessDirectoryController"

  .when "/me/audience",
    # templateUrl: "alphaBusiness.html"
    controller: "AudienceController"
    templateUrl: "alphaBusiness.html"
    resolve:
      'currentUserx': "TEST"
       
  $locationProvider.html5Mode true
  return

  $(document).on('ready page:load', ->
    angular.bootstrap(document, ['NM'])
  )
