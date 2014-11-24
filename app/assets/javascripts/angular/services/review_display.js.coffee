App.factory "ReviewDisplay", [
  "$q"
  "Restangular"
  "AuthService"
  "Utilities"

  ($q, Restangular, AuthService, Utilities) ->

    buildReviewList: (source, displayList) ->
      if source && source.length > 0

          while displayList.length > 0 
            displayList.pop()

          for item, i in source 
            do (item) ->
              item.entity().then (reviewer)->
                displayList.push
                  id: item.id
                  content: item.content
                  score: item.score
                  reviewer: reviewer


] 