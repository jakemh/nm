angular.module("NM").factory "Business", [
  "$q"
  "Restangular"
  "RestangularPlus"
  "RestEntity"
  ($q, Restangular, RestangularPlus, RestEntity) ->
    Restangular.extendModel "businesses", (self) ->
      angular.extend self, RestangularPlus
      angular.extend self, RestEntity

      self.owner = ->
        Restangular.one("users", self.owner_id).get()

      self.getTags = ->
        self.getListPlus("tags")
      
      self.tags = []

      return self
]