angular.module("NM").factory "RestEntity", [
  "RestangularPlus"
  (RestangularPlus) ->	  
	 
    sentMessages: () ->
      @getListPlus("sent_messages", {all: true})

    receivedMessages: () ->
      @getListPlus("received_messages", {all: true})
   
    posts: (params) ->
      @getListPlus("posts", params)

    flag: (params) ->
      @getListPlus("flags", params)

    followers: () ->
      @getListPlus("followers")

    personalPosts: () ->
      @severalPlus("posts").getList()
]