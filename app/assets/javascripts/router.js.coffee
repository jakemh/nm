# For more information see: http://emberjs.com/guides/routing/

NextMission.Router.map () ->
  @resource("me", ->
    @resource("feed")
    @resource("followers")
    @resource("audience")
    )
  # @resource('posts')


NextMission.Router.reopen
  location: 'history'

