# ready = undefined
# ready = ->
#   # ahoy.trackClicks();
#   # NewsFeedController = Paloma.controller('Me/NewsFeed');

#   $('.feed__content').linkify({}, ->
#     );
#   $(".feed__entry-select").select2();
#   $(".feed__entry-select").change ->
#     # alert $(@).val()
#     value = JSON.parse($(@).val())
#     idVal = value[1]
#     img = value[2]
#     objType = value[0]
#     name = value[3]
#     action = null
#     url: "/me/feed"

#     if objType == "Business"
#       action = "/me/businesses/" + idVal + "/posts"
#     else if objType == "User"
#       action = "posts"

#     $("#js-post-form, #js-post-form-response").attr("action", action);
#     # alert $(".feed__entry-inner--left img").attr("src")
#     $(".feed__entry-inner--left img").attr("src",img)
#     $(".js-form-name").html(name)
    
#   $(".js-feed-comment").on("click", (e) ->
#     e.preventDefault()
#     commentElement = $(@).closest(".feed__content-outer").find(".feed__comment-input")
#     commentElement.slideDown()
#     )
  
# $(document).ready ready
# $(document).on "page:load", ready

# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/
