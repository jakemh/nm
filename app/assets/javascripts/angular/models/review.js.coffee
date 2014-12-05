App.factory "Review", [

  "$q"
  "MessageBase"
  "Restangular"
  "RestangularPlus"
  "RestEntity"

  ($q, MessageBase, Restangular, RestangularPlus, RestEntity) ->

    Restangular.extendModel "reviews", (self) ->
      angular.extend self, MessageBase
      angular.extend self, RestangularPlus

      # self.entity = ->
      #   MessageBase.entity(self)

      
      return self
]