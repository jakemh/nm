App.factory "PointService", [
  "$q"
  "RestangularPlus"
  "AuthService"

  ($q, RestangularPlus, AuthService) ->
  	alreadyVoted: (post) ->
  	  moment(post.last_vote_current_user).add(1, "days").diff(moment()) > 0


  	disableTop: (post) ->
  	  post.getExistingScore() >= 1

  	disableBottom: (post) ->
  	  post.getExistingScore() <= -1

  	existingScore: (post) ->
  	  post.getExistingScore()

  	

  	upVote: (post) ->

  	  post.addPoints(1)
  	  post.post("points", angular.extend({}, {score: 1}, AuthService.currentId())).then (point) ->
        #callback

  	downVote: (post) ->
  	
  	  post.addPoints(-1)
  	  post.post("points", angular.extend({}, {score: -1}, AuthService.currentId())).then (point) ->
        #callback
]