angular.module("NM").factory "User", [

  "$q"
  "Restangular"
  "RestangularPlus"
  "RestEntity"

  ($q, Restangular, RestangularPlus, RestEntity) ->
    Restangular.extendModel "users", (self) =>
      angular.extend self, RestangularPlus
      angular.extend self, RestEntity

      self.businesses = ->
        self.getListPlus("businesses")
 
      return self
]