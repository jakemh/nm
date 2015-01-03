"use strict";

App.factory "ReviewService", [
  "$q"
  "CacheService"
  "Restangular"
  
  ($q, CacheService, Restangular) ->
    messageEntity: null
    
    # setMessageEntity: (entity)->
    #   @messageEntity = entity
    class SendReview
      constructor: (@reviewObj, @toEntity, @callback) ->

    initReviewModal: (reviewObj, toEntity, callback) ->
      sr = new SendReview(reviewObj, toEntity, callback)
      return sr


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
    
   
    sendReview: (sendReviewObj)->
      r = sendReviewObj
      business = r.toEntity
      business.review(r.reviewObj).then (response) =>
        business.addReview(response)
        # $q.when(response)
        # $("#js__business-review-modal").modal('hide')
        r.callback(response)
    # submit: (model, entity, entryForm, callback) ->
    #   alert JSON.stringify model
    #   if entryForm.$valid
    #     entryForm.hasError = false;
    #     callback(entity, model)
    #     model.content = ""
    #   else 
    #     entryForm.hasError = true

]
