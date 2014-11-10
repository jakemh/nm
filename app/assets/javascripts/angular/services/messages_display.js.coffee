App.factory "MessagesDisplay", [
  "$q"
  "Restangular"
  "AuthService"
  ($q, Restangular, AuthService) ->

    displayHash: (post, entity, responseList) ->
      models: {entity: entity}
      id: post.id
      timeStamp: moment(post.created_at)
      city: entity.city
      newPost: {}
      parentId: post.parent_id
      messageRoute: entity.message_route
      name: entity.name
      responses: responseList
      # distance: entity.distance
      added: post.created_at
      uri: entity.uri
      thumb: entity.thumb
      content: post.content
      profile: entity.uri
      entityType: entity.type
      entityId: entity.id
      followerUri: AuthService.followerUri(entity)
      followerUriType: AuthService.followerType(entity)
      followerCount: entity.follower_count


    buildEachPost: (displayList, post) ->
      displayHash = (post, entity, responseList) ->
        models: {entity: entity}
        id: post.id
        timeStamp: moment(post.created_at)
        city: entity.city
        newPost: {}
        parentId: post.parent_id
        messageRoute: entity.message_route
        name: entity.name
        responses: responseList
        # distance: entity.distance
        added: post.created_at
        uri: entity.uri
        thumb: entity.thumb
        content: post.content
        profile: entity.uri
        entityType: entity.type
        entityId: entity.id
        followerUri: AuthService.followerUri(entity)
        followerUriType: AuthService.followerType(entity)
        followerCount: entity.follower_count

      current = AuthService.currentEntitySelection.selected
      post.entity({current_type: current.type, current_id: current.id}).then (e)=>
        post.responses().then (responses) =>
          responseList = []
          
          for response in responses
            do (response) =>
              response.entity({current_type: current.type, current_id: current.id}).then (rE) =>
                responseList.push displayHash(response, rE)

          entity = e
          
          displayList.push displayHash(post, entity, responseList)
      
    buildMessageDisplay2: (displayList, source) ->
      deferred = $q.defer()
      if source
        list = []

        while displayList.length > 0 
          displayList.pop()
        

        for post in source
          # do (post) =>
            _.defer @buildEachPost, displayList, post


    buildMessageDisplay: (displayList, source) ->
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
              post.responses().then (responses) =>
                responseList = []
                
                for response in responses
                  do (response) =>
                    response.entity({current_type: current.type, current_id: current.id}).then (rE) =>
                      responseList.push @displayHash(response, rE)

                        # followerUriType: rE.follower_uri_type

                entity = e
                
                list.push @displayHash(post, entity, responseList)


                  # followerUriType: entity.follower_uri_type



                if list.length == source.length
                  deferred.resolve(list) 

      return deferred.promise
] 