angular.module("NM").factory "RestEntity", [
  "RestangularPlus"
  "$q"
  (RestangularPlus, $q) ->

      items: []
      receivedMessages: []
      sentMessages: []
      allMessages: ->
        @receivedMessages.concat @sentMessages

      unreadMessages: []
      following: []
      followers: []

      sentMessagesTo: (entity) ->
        @getListPlus "sent_messages",
          from_id: entity.id 
          from_type: entity.type

      receivedMessagesFrom: (entity) ->
        @getListPlus "received_messages",
          from_id: entity.id 
          from_type: entity.type
      
      buildSentMessages: (params) ->
        @getSentMessages().then (msgs) =>
          @sentMessages = msgs

      buildReceivedMessages: (params) ->
        @getReceivedMessages().then (msgs) =>
          @receivedMessages = msgs

      addSentMessageId: (id) ->
        @sent_message_ids.push id

      addReceivedMessageId: (id) ->
        @received_message_ids.push id

      getSentMessages: (params) ->
        @severalPlus2 "sent_messages",
          @sent_message_ids, 
          params

      getReceivedMessages: (params) ->

        @severalPlus2 "received_messages",
          @received_message_ids,
          params
      
      getAllMessages: ->
        # deferred = $q.defer();

        $q.all([@getReceivedMessages(), @getSentMessages()]).then (all) ->
          allMessages = []
          for array in all
            allMessages = allMessages.concat array

          $q.when(allMessages)
          # deferred.resolve(allMessages)
          
        # return deferred.promise
      receivedMessagesFrom: (entity, entityMessages) ->
        entity.received

      getItems: ->
        @getListPlus("items")   

      # addFollower: (entity)->

      pushFollowing: (entity)->
        if entity.type == "User"
          @user_connection_ids.push(entity.id)
        else if entity.type = "Business"
          @business_connection_ids.push(entity.id)

      followerCount: () ->
        this.follower_count

      canBeFollowedBy: (userEntity) ->
        if this == userEntity
          return false #same entity

        if @type == "Business"
          return true #business can be followed by anythign but themselves

        else if @type == "User"
          if userEntity.type == "User"
            true #users can follow any user but themselves
          else if userEntity.type == "Business"
            return false #busines cannot follower user


      isFollowedBy: (userEntity) ->
        if @type == "Business"
          if _.contains(userEntity.business_connection_ids, this.id)
            return true
          else return false
        else if @type == "User"
          if _.contains(userEntity.user_connection_ids, this.id)
            return true 
          else return false
        else return false


      posts: (params) ->
        # @getListPlus("posts", params)
        @severalPlus2("posts", @feed_post_ids)

      flag: (params) ->
        @post('flags', params)
        # @getListPlus("flags", params).post(params)

      getFollowers: () ->
        console.log @follower_ids
        @severalPlus2("followers", @follower_ids)

      getFollowing: () ->
        @severalPlus2("following", @following_ids)

      personalPosts: () ->
        @severalPlus("posts").getList()

      


    # entityType: 
]