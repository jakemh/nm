window.App = angular.module("NM", [
  "ngRoute"
  "templates"
  "rails"
  "ui.select"
  "ngSanitize"
  "ngResource"
  "restangular"
  "ngAnimate"
  
]).config ($routeProvider, $locationProvider, $httpProvider, RestangularProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  RestangularProvider.setRequestSuffix('.json');
  # RestangularProvider.addRequestInterceptor (element, operation, what, url) ->

  RestangularProvider.addResponseInterceptor (data, operation, what, url, response, deferred) ->
    # console.log "Data: " + JSON.stringify(data) + " Operation: " + operation + " What: " + what + " URL: " + url + " Response: " + JSON.stringify(response) + " Deferred: " + JSON.stringify(deferred)
    key = Object.keys(data)[0];
    extractedData = data  

    if key == "user" || key == "business"
      extractedData = data[key]

    if (operation == "getList")
      # console.log("TEST: " + JSON.stringify(data))
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
