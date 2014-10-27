angular.module("NM").controller "MessagesController", [
  "$scope"
  "Utilities"
  "AuthService"
  "Restangular"
  ($scope,  Utilities, AuthService, Restangular) ->
    # $scope.messages = []
    $scope.sentMessages = []
    $scope.receivedMessage = []
    $scope.searching = []
    $scope.AuthService = AuthService
    $scope.Utilities = Utilities
    $scope.displayMessages = []

    $scope.$watch 'AuthService.currentUser', ->
      if AuthService.currentUser
        AuthService.currentUser.sentMessages().then (sent) ->
          $scope.sentMessages = sent

        AuthService.currentUser.receivedMessages().then (received) ->
          $scope.receivedMessages = received
        # alert JSON.stringify AuthService.currentUser

        # AuthService.currentUser.messages().then (messages)->
          # messages[0].entity().then (entity)->
            # alert JSON.stringify entity
          # messages[0].entity()
      # if AuthService.currentUser
        # AuthService.currentUser.test()
        # AuthService.currentUser.messages().then (m)->
        #   alert JSON.stringify m[0]
        #   m[0].test()
        # AuthService.currentUser.messages().then (m)->
          # messages = m["messages"]
          # alert JSON.stringify messages[0]

        # Message.query({userId: AuthService.currentUser.id}).then ((results) ->
        #   # $scope.displayList = results["entities"]
        #   alert JSON.stringify results[0].user
        #   # $scope.searching = false
        #   return
        # ), (error) ->
        
        # $scope.messages = AuthService.currentUser.messages
        # alert JSON.stringify AuthService.currentUser.messages
]