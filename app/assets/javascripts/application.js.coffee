#= require jquery
#= require bootstrap-sass-official/assets/javascripts/bootstrap-sprockets
#= require bootstrap-sass-official/assets/javascripts/bootstrap
#= require jquery_ujs
#= require jQuery-linkify/src/linkified
#= require jQuery-linkify/src/jquery.linkify
#= require turbolinks
#= require jquery.tagsinput/jquery.tagsinput.js
#= require ahoy
#= require landing
#= require underscore
#= require gmaps/google

#= require json2
#= require judge
#= require registration
#= require select2
#= require jquery-fileupload

#= require handlebars

#= require_self
#= require messages
#= require user_profile
#= require me/photos
#= require me/news_feed
#= require me/businesses
#= require me/audience

#= require paloma

$(document).on "page:load", ->
  Paloma.executeHook()
  Paloma.engine.start()
  return


# for more details see: http://emberjs.com/guides/application/
# window.NextMission = Ember.Application.create(
#   rootElement: '#nm-root'
#   LOG_TRANSITIONS: true
#   )

