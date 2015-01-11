angular.module("NM").factory "Assignment", [

  "$q"
  "Restangular"
  "RestangularPlus"

  ($q, Restangular, RestangularPlus) ->
    Restangular.extendModel "assignments", (self) =>
      angular.extend self, RestangularPlus
      
      
      return self
]