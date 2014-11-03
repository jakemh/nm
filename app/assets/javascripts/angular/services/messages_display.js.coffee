App.factory "MessagesDisplay", [
  "$q"
  "Restangular"
  ($q, Restangular) ->
    buildMessageDisplay: (displayList, source) ->
      deferred = $q.defer()

      if source
        list = []

        # while displayList.length > 0 
        #   displayList.pop()
        

        for post in source
          do (post) ->
            # alert post.entity() + " XXX " + JSON.stringify post
            post.entity().then (e)->
              post.responses().then (responses) ->
                responseList = []

                for response in responses
                  do (response) ->
                    response.entity().then (rE) ->
                      responseList.push
                        id: response.id
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

                entity = e
                
                list.push
                  id: post.id
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

                if list.length == source.length
                  deferred.resolve(list) 

      return deferred.promise
] 
