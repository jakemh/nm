App.factory "MessagesDisplay", [
  "$q"
  "Restangular"
  "AuthService"
  "Utilities"
  ($q, Restangular, AuthService, Utilities) ->

    displayHash: (post, entity, responseList) ->
      models: {entity: entity, post: post}
      id: post.id
      timeStamp: moment(post.created_at)
      city: entity.city
      newPost: {}
      parentId: post.parent_id
      messageRoute: entity.message_route
      timeFromNow: Utilities.timeDifference(moment(post.created_at))
      name: entity.name
      responses: responseList
      added: post.created_at
      uri: entity.uri
      thumb: entity.thumb
      content: post.content
      profile: entity.uri
      unread: post.unread
      entityType: entity.type
      entityId: entity.id
      getPoints: -> post.getPoints()
      # followerUri: AuthService.followerUri(entity)
      # followerUriType: AuthService.followerType(entity)
      followerCount: entity.follower_count
    

    buildResponse: (responseList, current, context, response) ->
      do (response) =>
        response.entity({current_type: current.type, current_id: current.id}).then (rE) =>
          responseList.push context.displayHash(response, rE)

    buildEachPost: (displayList, post, options, context, callback) ->
      current = AuthService.currentEntitySelection.selected
      post.entity({current_type: current.type, current_id: current.id}).then (e)=>
        entity = e
 
        if !(options && options.suppressResponses)
          post.responses().then (responses) =>
            responseList = []
            for response, i in responses
              _.delay context.buildResponse, i*1, responseList, current, context, response
            displayList.push context.displayHash(post, entity, responseList)
            callback(i) if callback
        else 
          displayList.push context.displayHash(post, entity)
          callback() if callback


    buildMessageDisplay2: (displayList, source, options, callback) ->

      if source
        list = []

        while displayList.length > 0 
          displayList.pop()
    
        for post, i in source
          _.delay @buildEachPost, i*1, displayList, post, options, @, (j) ->

            callback(j) if callback

    # buildMessageDisplayWithPromise: (displayList, source, options) ->
    #   deferred = $q.defer()
    #   @buildMessageDisplay2 displayList, source, options, (i) ->
    #     # debugger
    #     deferred.resolve(null) if source.length == displayList.length

    #   return deferred.promise

    buildMessageDisplay: (source, options) ->
      deferred = $q.defer()

      if source
        list = []

        # while displayList.length > 0 
        #   displayList.pop()
        
        current = AuthService.currentEntitySelection.selected

        for post in source
          do (post) =>
            # alert post.entity() + " XXX " + JSON.stringify post
            post.entity({current_type: current.type, current_id: current.id}).then (e)=>
              entity = e

              if !(options && options.suppressResponses)
                post.responses().then (responses) =>
                  responseList = []
                  
                  for response in responses
                    do (response) =>
                      response.entity({current_type: current.type, current_id: current.id}).then (rE) =>
                        responseList.push @displayHash(response, rE)
                        
                  list.push @displayHash(post, entity, responseList)
                  deferred.resolve(list) if list.length == source.length

              else 
                list.push context.displayHash(post, entity)

      return deferred.promise
] 