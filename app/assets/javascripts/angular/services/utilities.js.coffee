App.factory "Utilities", [
    "$sce"
    ($sce) ->
      trustAsHtml: (value) ->
        return $sce.trustAsHtml(value);

      timeAgoThreshhold: -259200000

      testing: true

      timeDifference: (t) ->
        t.diff(moment())


      exceedThreshold: (timeAgo)->
        if timeAgo < @timeAgoThreshhold
          true
        else false

      entityCompare: (e1, e2)->
        
        e1F = [e1.id, e1.type]
        e2F = [e2.id, e2.type]
        
        if angular.equals(e1F, e2F)
          return true
        else return false

  


]
