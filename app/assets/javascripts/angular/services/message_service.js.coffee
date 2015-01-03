
App.factory "MessageService", [
  "$q"
  "CacheService"
  "Restangular"
  "RestangularPlus"
  "AuthService"
  ($q, CacheService, Restangular, RestangularPlus, AuthService) ->

    unreadList: []
    currentEntity: null
    class SendMessage
      constructor: (@messageObj, @toEntity, @callback) ->

    setMessageEntity: (entity)->
      @messageEntity = entity

    initMessageModal: (messageObj, toEntity, callback) ->
      # @setMessageEntity(entity)
      # @callModal('js-msg__modal')
      sm = new SendMessage(messageObj, toEntity, callback)
      return sm
    
    initMessageForm: (messageObj, toEntity, callback) ->
      # @setMessageEntity(entity)
      # @callModal('js-msg__modal')
      sm = new SendMessage(messageObj, toEntity, callback)
      return sm

    callModal: (id, $event)->
      $($event.currentTarget).parents(".modal-link-container").find(".js-msg__modal").modal()
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

    buildEntityMessageList: (displaySubEnt, messages) ->
      for msg in messages 
        if msg.type == "ReceivedMessage"
          if displaySubEnt.entity.id == msg.entity_id && displaySubEnt.entity.type == msg.entity_type 
            displaySubEnt.messages.push msg

        else if msg.type == "SentMessage"
          if displaySubEnt.entity.id == msg.to_entity_id && displaySubEnt.entity.type == msg.to_entity_type 
            displaySubEnt.messages.push msg

      _.sortBy displaySubEnt.messages, (m) -> m.id


  

    buildEntityUnreadList: (displayEntities, messages)->
      for dEntity in displayEntities
        entities = dEntity.entitiesList
        for e in dEntity.entitiesList
          # e.unreadMessages = []
          while e.unreadMessages.length > 0
            e.unreadMessages.pop()

        for msg in msgs
          #assignToEntity returns entity if
          #message was sent from him and 
          #was sent to current selected entity

          assignToEntity = _.find entities, (e) -> 
            # debugger
            e.id == msg.entity_id && 
            e.type == msg.entity_type &&
            (msg.to_entity_id == currentEntity.id &&
            msg.to_entity_type == currentEntity.type)

          if assignToEntity
            assignToEntity.unreadMessages.push(msg)

    loadUnreadMessages: (user) ->
      deferred = $q.defer();
      user.getListPlus('received_messages', {unread: true}).then (msgs)=>
        # currentEntity = AuthService.currentEntitySelection.selected
        # debugger
        # @unreadList = msgs
        deferred.resolve(msgs)

      return deferred.promise

    sendMessageModal: (sendMessageObj) ->
      @sendMessage(sendMessageObj)

    sendMessage: (sendMessageObj) ->
      sm = sendMessageObj
      
      currentEntity = AuthService.currentEntitySelection.selected
      toEntity = sm.toEntity
      
      entityAttrs = 
        from_id: currentEntity.id
        from_type: currentEntity.type

        to_id: toEntity.id
        to_type: toEntity.type
        type: "Message"


      postSubmit = angular.extend({}, sm.messageObj, entityAttrs)
      currentEntity.post('messages', postSubmit).then (response)->
        sm.callback(response) if sm.callback
        $(".js-msg__modal").modal('hide')


    submitHandler: (obj, entryForm, submit) ->
      
      if entryForm.$valid
        entryForm.hasError = false;
        # obj.callback(obj.entity, obj.model) if callback
        submit(obj)
        # model.content = ""
      else 
        entryForm.hasError = true
      
    submit: (model, entity, entryForm, callback, parentList) ->
      # debugger
      if entryForm.$valid
        entryForm.hasError = false;
        callback(entity, model, parentList) if callback
        model.content = ""
      else 
        entryForm.hasError = true

]
