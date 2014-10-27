window.App = angular.module("NM", [
  "ngRoute"
  "templates"
  "rails"
  "ui.select"
  "ngSanitize"
  "ngResource"
  "restangular"
  
]).config ($routeProvider, $locationProvider, RestangularProvider) ->

  RestangularProvider.setRequestSuffix('.json');

  RestangularProvider.addResponseInterceptor (data, operation, what, url, response, deferred) ->
    extractedData = null  
    extractedData = data
    if (operation == "getList")
      key = Object.keys(data)[0];
      extractedData = data[key]
    
    return extractedData;
      

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
