angular.module("NM").factory "Affiliation", [

  "$q"
  "Restangular"
  "RestangularPlus"

  ($q, Restangular, RestangularPlus) ->
    Restangular.extendModel "affiliations", (self) =>
      
      return self
]