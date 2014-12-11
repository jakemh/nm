
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
    buildUserEntityUnreadList: (messages, userEntities)->
      for e in userEntities
        e.ownedUnreadMessages = []
        
      for msg in messages 
        for e in userEntities
          if msg.to_entity_id == e.id && msg.to_entity_type == e.type
            e.ownedUnreadMessages.push(msg)
            console.log e.name
            console.log  _.map(e.ownedUnreadMessages, (item)-> item.id)

      # debugger
      # for entity in userEntities


    buildEntityUnreadList: (entities, msgs, currentEntity)->
      for e in entities
        e.unreadMessages = []
        
      for msg in msgs
        assignToEntity = _.find entities, (e) -> 
          # debugger
          e.id == msg.entity_id && 
          e.type == msg.entity_type &&
          (msg.to_entity_id == currentEntity.id &&
          msg.to_entity_type == currentEntity.type)

        if assignToEntity
          assignToEntity.unreadMessages.push(msg)

    loadUnreadMessages: (entity)->
      deferred = $q.defer();
      entity.receivedMessages(unread: true).then (msgs)=>
        # currentEntity = AuthService.currentEntitySelection.selected
        # debugger
        # @unreadList = msgs
        deferred.resolve(msgs)

        # $scope.SideBar.messageCount = $scope.unreadList.length
        

      return deferred.promise
    
    submit: (model, entity, entryForm, callback, parentList) ->
      if entryForm.$valid
        entryForm.hasError = false;
        callback(entity, model, parentList)
        model.content = ""
      else 
        entryForm.hasError = true

]
