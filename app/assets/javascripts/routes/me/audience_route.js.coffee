NextMission.AudienceRoute = Ember.Route.extend Ember.Evented,

  setupController: (controller, model) ->

  renderTemplate: ->
    @render('me/audience', {
      controller: @controllerFor("audience")
      })