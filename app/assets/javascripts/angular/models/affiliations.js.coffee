angular.module("NM").factory "Affiliation", [

  "$q"
  "Restangular"
  "RestangularPlus"

  ($q, Restangular, RestangularPlus) ->
    Restangular.extendModel "affiliations", (self) =>
      angular.extend self, RestangularPlus

      self.branch = () ->
      	
      	RestangularPlus.getModel("branches", self.branch_id)

      return self
]