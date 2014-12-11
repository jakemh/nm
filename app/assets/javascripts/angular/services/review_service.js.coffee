"use strict";

App.factory "ReviewService", [
  "$q"
  "CacheService"
  "Restangular"
  
  ($q, CacheService, Restangular) ->
    messageEntity: null
    
    # setMessageEntity: (entity)->
    #   @messageEntity = entity

    newReview: ()->
      return {score: 0, content: ""}

    averageScore: (reviews)->
      if reviews && reviews.length > 0
        sum = 0
        for review in reviews 
          sum += review.score 

        ave = sum / (reviews.length)

        return Math.round(ave * 10) / 10
      else return 0

    callModal: ()->
      $("#js__business-review-modal").modal()
      return true

    hideModal: ()->
      $("#js__business-review-modal").modal('hide')
      return true

    # # sendMessage: ()->

    # newPost: {}
    # entity: null
    rateFunction: (rating) ->
      # alert "Rating selected - " + rating
      return
    
   
    sendPost: (business, post)->
      business.review(post).then (response) =>
        $("#js__business-review-modal").modal('hide')
    # submit: (model, entity, entryForm, callback) ->
    #   alert JSON.stringify model
    #   if entryForm.$valid
    #     entryForm.hasError = false;
    #     callback(entity, model)
    #     model.content = ""
    #   else 
    #     entryForm.hasError = true

]
