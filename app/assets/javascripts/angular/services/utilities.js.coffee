App.factory "Utilities", [
    "$sce"
    ($sce) ->
      trustAsHtml: (value) ->
        return $sce.trustAsHtml(value);
      

      millisecondsPerDay: 86400000

      entityRoute: (entity) ->
        if entity.type == "User"
          return "users"
        else if entity.type == "Business"
          return "businesses"
          
      entityLink: (type, id) ->
        if type == "Business"
          return "businesses/#{id}"
        else if type == "User"
          return "users/#{id}"

      timeAgoThreshhold: ->
        days = 3
        -1 * days * @millisecondsPerDay

      testing: true

      timeDifference: (t) ->
        t.diff(moment())


      exceedThreshold: (timeAgo)->
        if timeAgo < @timeAgoThreshhold()
          true
        else false

      entityCompare: (e1, e2)->
        
        e1F = [e1.id, e1.type]
        e2F = [e2.id, e2.type]
        
        if angular.equals(e1F, e2F)
          return true
        else return false

  


]
