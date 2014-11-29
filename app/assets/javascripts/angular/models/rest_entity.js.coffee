angular.module("NM").factory "RestEntity", [
  "RestangularPlus"
  (RestangularPlus) ->	  

    sentMessages: (entity) ->
      @getListPlus "sent_messages",
        from_id: entity.id 
        from_type: entity.type

    receivedMessages: (entity) ->
      @getListPlus "received_messages",
        from_id: entity.id 
        from_type: entity.type
    
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