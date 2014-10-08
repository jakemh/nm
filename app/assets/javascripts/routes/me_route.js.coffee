NextMission.MeRoute = Ember.Route.extend Ember.Evented,
  
  setupController: (controller, model) ->


  # childControllers: (->
  #   "feed" : @controllerFor('feed')
  #   "audience" : @controllerFor('audience')
  #   "followers" : @controllerFor('followers')

  #   ).property()

  # template: ->
  #   template = @modelFor('activities').get('template') || 'empty'

  # renderTemplate: ->
  #   childControllers = @get('childControllers')
  #   activitiesController = @controllerFor('activities');
  #   newWordController = @controllerFor('newWord');

  #   template = @template()
  #   @render('activities/' + template, {
  #     into: 'me'
  #     controller: childControllers[template] 
  #     })

