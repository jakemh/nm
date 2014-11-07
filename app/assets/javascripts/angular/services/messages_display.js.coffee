App.factory "MessagesDisplay", [
  "$q"
  "Restangular"
  "AuthService"
  ($q, Restangular, AuthService) ->

    buildMessageDisplay2: (displayList, source) ->
      deferred = $q.defer()

      if source
        list = []

        while displayList.length > 0 
          displayList.pop()
        
        current = AuthService.currentEntitySelection.selected

        for post in source
          do (post) ->
            # alert post.entity() + " XXX " + JSON.stringify post
            post.entity({current_type: current.type, current_id: current.id}).then (e)->
              post.responses().then (responses) ->
                responseList = []
                
                for response in responses
                  do (response) ->
                    response.entity({current_type: current.type, current_id: current.id}).then (rE) ->
                      responseList.push
                        models: {entity: rE}
                        id: response.id
                        timeStamp: moment(response.created_at)
                        city: rE.city
                        newPost: {}
                        parentId: response.parent_id
                        messageRoute: rE.message_route
                        name: rE.name
                        # distance: entity.distance
                        added: response.created_at
                        uri: rE.uri
                        thumb: rE.thumb
                        content: response.content
                        profile: rE.uri
                        entityType: rE.type
                        entityId: rE.id
                        followerUri: AuthService.followerUri(rE)
                        followerUriType: AuthService.followerType(rE)
                        followerCount: rE.follower_count
                        # followerUriType: rE.follower_uri_type

                entity = e
                
                displayList.push
                  models: {entity: entity}
                  id: post.id
                  timeStamp: moment(post.created_at)
                  city: entity.city
                  newPost: {}
                  uri: entity.uri
                  parentId: null
                  name: entity.name
                  messageRoute: entity.message_route
                  responses: responseList
                  # distance: entity.distance
                  added: post.created_at
                  thumb: entity.thumb
                  content: post.content
                  profile: entity.uri
                  entityType: entity.type
                  entityId: entity.id
                  followerUri: AuthService.followerUri(entity)
                  followerUriType: AuthService.followerType(entity)
                  followerCount: entity.follower_count

                  # followerUriType: entity.follower_uri_type


    buildMessageDisplay: (displayList, source) ->
      deferred = $q.defer()

      if source
        list = []

        # while displayList.length > 0 
        #   displayList.pop()
        
        current = AuthService.currentEntitySelection.selected

        for post in source
          do (post) ->
            # alert post.entity() + " XXX " + JSON.stringify post
            post.entity({current_type: current.type, current_id: current.id}).then (e)->
              post.responses().then (responses) ->
                responseList = []
                
                for response in responses
                  do (response) ->
                    response.entity({current_type: current.type, current_id: current.id}).then (rE) ->
                      responseList.push
                        models: {entity: rE}
                        id: response.id
                        timeStamp: moment(response.created_at)
                        city: rE.city
                        newPost: {}
                        parentId: response.parent_id
                        messageRoute: rE.message_route
                        name: rE.name
                        # distance: entity.distance
                        added: response.created_at
                        uri: rE.uri
                        thumb: rE.thumb
                        content: response.content
                        profile: rE.uri
                        entityType: rE.type
                        entityId: rE.id
                        followerUri: AuthService.followerUri(rE)
                        followerUriType: AuthService.followerType(rE)
                        followerCount: rE.follower_count
                        # followerUriType: rE.follower_uri_type

                entity = e
                
                list.push
                  models: {entity: entity}
                  id: post.id
                  timeStamp: moment(post.created_at)
                  city: entity.city
                  newPost: {}
                  uri: entity.uri
                  parentId: null
                  name: entity.name
                  messageRoute: entity.message_route
                  responses: responseList
                  # distance: entity.distance
                  added: post.created_at
                  thumb: entity.thumb
                  content: post.content
                  profile: entity.uri
                  entityType: entity.type
                  entityId: entity.id
                  followerUri: AuthService.followerUri(entity)
                  followerUriType: AuthService.followerType(entity)
                  followerCount: entity.follower_count

                  # followerUriType: entity.follower_uri_type



                if list.length == source.length
                  deferred.resolve(list) 

      return deferred.promise
] 