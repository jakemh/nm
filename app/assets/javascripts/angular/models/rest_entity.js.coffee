angular.module("NM").factory "RestEntity", [
  "RestangularPlus"
  (RestangularPlus) ->	  

    sentMessagesTo: (entity) ->
      @getListPlus "sent_messages",
        from_id: entity.id 
        from_type: entity.type

    receivedMessagesFrom: (entity) ->
      @getListPlus "received_messages",
        from_id: entity.id 
        from_type: entity.type
    
    sentMessages: (params) ->
      @getListPlus "sent_messages",
        params

    receivedMessages: (params) ->
      @getListPlus "received_messages",
        params
      
    getItems: ->
      @getListPlus("items")   

    pushFollowing: (entity)->
      if entity.type == "User"
        @user_connection_ids.push(entity.id)
      else if entity.type = "Business"
        @business_connection_ids.push(entity.id)

    canFollow: (userEntity) ->
      if @type == "Business"
        if _.contains(userEntity.business_ids, this.id)
          return true #"YOU OWN THIS!!"
        else if this == userEntity 
          return false #return "YOU!!"
        else if _.contains(userEntity.business_connection_ids, this.id)
          return true #return "FOLLOWING"
        else true #return "FOLLOW [*]"

      else if @type == "User"
        if userEntity.type == "Business"
          return false #Can't follow users from businesses
        else if this == userEntity   
          return false #return "YOU!!"
        else if _.contains(userEntity.user_connection_ids, this.id)
          return true #return "FOLLOWING"
        else if userEntity.owner_id == this.id 
          return false #return "YOUR OWNER"
        else true #return "FOLLOW [*]"


    isFollowing: (userEntity) ->
      if @type == "Business"
        if _.contains(userEntity.business_connection_ids, this.id)
          return true
        else return false
      else if @type == "User"
        if _.contains(userEntity.user_connection_ids, this.id)
          return true 
        else return false
      else return false


    # ownedUnreadMessages: []
    

    # sentMessages: (entity) ->
    #   alert JSON.stringify 
    #   @getList "sent_messages",
    #     from_id: entity.id 
    #     from_type: entity.type

    # receivedMessages: (entity) ->
    #   @getList "received_messages",
    #     from_id: entity.id 
    #     from_type: entity.type
    

    posts: (params) ->
      @getListPlus("posts", params)

    flag: (params) ->
      @post('flags', params)
      # @getListPlus("flags", params).post(params)

    followers: () ->
      @getListPlus("followers")

    personalPosts: () ->
      @severalPlus("posts").getList()


    # entityType: 
]