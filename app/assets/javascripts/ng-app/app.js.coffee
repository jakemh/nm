"use strict";

class DisplayModel
  constructor: (@entity) ->


class AudienceDisplay extends DisplayModel
  constructor: (@entity) ->
    @followersDisplay = []
    @followingDisplay = []
    @allConnections = []

  buildAllConnections: ->  
    # connections = @followersDisplay.concat @followingDisplay

    connections = []

    for follower in @followersDisplay
      exists = _.find connections, (item) -> item.models.entity == follower.models.entity
      if exists
        exists.relationships.push "Follower"
      else connections.push follower
    
    for following in @followingDisplay
      exists = _.find connections, (item) -> item.models.entity == following.models.entity
      if exists
        exists.relationships.push "Following"
      else connections.push following

    @allConnections = connections
    return @allConnections
    # for connection in connections

      # if _.contains @entity.follower_ids, connection.id


class MessagesDisplay extends DisplayModel
  constructor: (@entity) ->
    @entitiesList = []
    @allMessages = []

  buildEntitiesList: ->
    list = []
    for m in @allMessages
      if m.type == "ReceivedMessage"
        list.push m.entity()
      else if m.type == "SentMessage"
        list.push m.toEntity()
        
    return list
        # @entitiesList.push e

  # @entitiesList: []

  getEntitiesList: ->
    _.uniq @entitiesList

  
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
  "infinite-scroll"
  "flow"
  "ng-rails-csrf"
  "ngTouch"  
  "linkify"
  "vr.directives.slider"
  "ngFitText"
  "angularSpinner"
  "angular-ladda"
  
]).config ($routeProvider, $locationProvider, $httpProvider, RestangularProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  RestangularProvider.setRequestSuffix('.json');
  # RestangularProvider.addRequestInterceptor (element, operation, what, url) ->
  # RestangularProvider.setDefaultHttpFields({cache: true});
  RestangularProvider.addFullRequestInterceptor (element, operation, what, url, headers, params, httpConfig) ->
    
    # console.log JSON.stringify 
 
    return element
    # if operation == "getList"



  RestangularProvider.setParentless(["businesses", "posts"]);


  RestangularProvider.addResponseInterceptor (data, operation, what, url, response, deferred) ->
    
    key = Object.keys(data)[0];

    extractedData = data  
    formattedData = extractedData[key]
    # console.log data
    # alert JSON.stringify data
    if key == "user" || key == "business" || key == "tags" || key == "post" || key == "response" || key == "message" || key == "received_message" || key == "sent_messages" || key == "cover_photo" || key == "profile_photo"
      extractedData = data[key]
    

    if (operation == "getList")

      formattedData = data[key]

      # alert JSON.stringify "APP.JS: " + formattedData
      if formattedData instanceof Array
        extractedData = formattedData
      else
        extractedData = [formattedData]  
    else if formattedData instanceof Array 
      extractedData = formattedData[0]
      # alert "TEST: " + JSON.stringify extractedData
      # alert "APP.JS: " + JSON.stringify extractedData

    # debugger
    
    return extractedData
      

  $routeProvider.when "/businesses",
    templateUrl: "business_directory.html"
    controller: "BusinessDirectoryController"

  .when "/me/feed",
  # controller: "PostController"

    templateUrl: "feed.html"
    resolve: 
      testing: ->
        return "100"
  .when "/users/:id",
    templateUrl: "profile.html"
    controller: "ProfileController"
    resolve:
      profileEntity: ($route, RestangularPlus)->
        id = $route.current.params.id
        return RestangularPlus.getModel('users', id).then (users) ->
          return users

  .when "/me/audience",
    templateUrl: "audience.html"
    controller: "AudienceController"
    resolve: 
      entityHash: ($route, AuthService, RestangularPlus)->
        AuthService.entityHash(AudienceDisplay).then (h) ->
          return h
      
  .when "/messages",
    templateUrl: "private_messages.html"
    controller: "MessagesController"
    resolve: 
      entityHash: ($route, AuthService, RestangularPlus)->
        AuthService.entityHash(MessagesDisplay).then (h) ->
          return h
  .when "/me/followers",
    templateUrl: "followers.html"
  .when "/businesses/:id",
    templateUrl: "profile.html"
    controller: "ProfileController"
    resolve:
      profileEntity: ($route, RestangularPlus)->
        id = $route.current.params.id
        return RestangularPlus.getModel('businesses', id).then (bus) ->
          return bus

  # .when('/users/:id', 
  #    {templateUrl: 'profile.html', controller: 'ProfileController'}
  #  );
  $locationProvider.html5Mode true
  return

  # $(document).on('ready page:load', ->
  #   angular.bootstrap(document, ['NM'])
  # )

App.run (editableOptions) ->
  editableOptions.theme = "bs3" # bootstrap3 theme. Can be also 'bs2', 'default'

