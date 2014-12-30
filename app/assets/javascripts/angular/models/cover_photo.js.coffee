angular.module("NM").factory "CoverPhoto", [
  "$q"
  "Restangular"
  "RestangularPlus"
  ($q, Restangular, RestangularPlus) ->
    Restangular.extendModel "businesses", (self) ->
      angular.extend self, RestangularPlus

      return self
]