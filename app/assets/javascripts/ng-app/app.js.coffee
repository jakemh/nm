window.App = angular.module("NM", [
  "ngRoute"
  "templates"
  "rails"
  "ui.select"
  "ngSanitize"
  "ngResource"
  "restangular"
  "ngAnimate"
  "pasvaz.bindonce"
  "xeditable"
  "ngTagsInput"
  "angularMoment"
  "ui.bootstrap"
  
]).config ($routeProvider, $locationProvider, $httpProvider, RestangularProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  RestangularProvider.setRequestSuffix('.json');
  # RestangularProvider.addRequestInterceptor (element, operation, what, url) ->
  # RestangularProvider.setDefaultHttpFields({cache: true});
  RestangularProvider.addFullRequestInterceptor (element, operation, what, url, headers, params, httpConfig) ->
    
    # console.log JSON.stringify 
 
    return element
    # if operation == "getList"



  RestangularProvider.setParentless(["businesses"]);


  RestangularProvider.addResponseInterceptor (data, operation, what, url, response, deferred) ->
    key = Object.keys(data)[0];
    extractedData = data  

    if key == "user" || key == "business"
      extractedData = data[key]
    

    if (operation == "getList")

      formattedData = data[key]

      # alert JSON.stringify "APP.JS: " + formattedData
      if formattedData instanceof Array
        extractedData = formattedData
      else
        extractedData = [formattedData]  
    
      # alert "TEST: " + JSON.stringify extractedData
      # alert "APP.JS: " + JSON.stringify extractedData

    return extractedData
      

  $routeProvider.when "/",
    templateUrl: "home.html"
    controller: "HomeCtrl"

  .when "/businesses",
    templateUrl: "business_directory.html"
    controller: "BusinessDirectoryController"

  .when "/me/feed",
    templateUrl: "feed.html"
    # controller: "PostController"
    resolve:
      rightBarTemplate: ->
        "blank.html"
  .when "/users/:id",
    templateUrl: "profile.html"
  .when "/me/audience",
    templateUrl: "audience.html"
  .when "/messages",
    templateUrl: "private_messages.html"
  .when "/me/followers",
    templateUrl: "followers.html"
  .when "/businesses/:id",
    templateUrl: "profile.html"


  .when('/users/:id', 
     {templateUrl: 'profile.html', controller: 'ProfileController'}
   );
  $locationProvider.html5Mode true
  return

  # $(document).on('ready page:load', ->
  #   angular.bootstrap(document, ['NM'])
  # )

App.run (editableOptions) ->
  editableOptions.theme = "bs3" # bootstrap3 theme. Can be also 'bs2', 'default'

