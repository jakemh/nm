angular.module("NM").factory "RestEntity", [
  "RestangularPlus"
  (RestangularPlus) ->

      ownedUnreadMessages: []
      items: []
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
      
      # sentMessages: (params) ->
      #   @getListPlus "sent_messages",
      #     params

      # receivedMessages: (params) ->
      #   @getListPlus "received_messages",
      #     params
        

      sentMessages: (params) ->
        @severalPlus2 "sent_messages",
          @sent_message_ids, 
          params

      receivedMessages: (params) ->
        @severalPlus2 "received_messages",
          @received_message_ids,
          params
      
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

      followers: () ->
        console.log @follower_ids
        @severalPlus2("followers", @follower_ids)

      following: () ->
        @severalPlus2("following", @following_ids)

      personalPosts: () ->
        @severalPlus("posts").getList()


    # entityType: 
]