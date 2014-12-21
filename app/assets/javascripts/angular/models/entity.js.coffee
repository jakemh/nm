angular.module("NM").factory "Entity", [
  "$q"
  "Restangular"
  "RestangularPlus"
  "RestEntity"
  ($q, Restangular, RestangularPlus, RestEntity) ->
    Restangular.extendModel "entities", (self) ->
      angular.extend self, RestangularPlus
      angular.extend self, angular.copy(RestEntity)

      return self
]