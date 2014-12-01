
App.factory "MessageService", [
  "$q"
  "CacheService"
  "Restangular"
  ($q, CacheService, Restangular) ->
    messageEntity: null
    
    unreadList: []
    setMessageEntity: (entity)->
      @messageEntity = entity

    callModal: (id, $event)->
      $("#" + id).modal()
      return true

    # sendMessage: ()->

    buildEntityUnreadList: (entities, msgs, currentEntity)->
      for e in entities
        e.unreadMessages = []
       
      for msg in msgs
        entity = _.find entities, (ent) -> 
          # debugger
          ent.id == msg.entity_id && 
          ent.type == msg.entity_type &&
          (msg.to_entity_id == currentEntity.id &&
          msg.to_entity_type == currentEntity.type)

        if entity
          entity.unreadMessages.push(msg)

    loadUnreadMessages: (entity)->
      deferred = $q.defer();

      entity.receivedMessages(unread: true).then (msgs)->
        # currentEntity = AuthService.currentEntitySelection.selected
        unreadList = msgs
        deferred.resolve(msgs)

        # $scope.SideBar.messageCount = $scope.unreadList.length
        

      return deferred.promise

    submit: (model, entity, entryForm, callback) ->
      if entryForm.$valid
        entryForm.hasError = false;
        callback(entity, model)
        model.content = ""
      else 
        entryForm.hasError = true

]
