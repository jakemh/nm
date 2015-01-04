angular.module("NM").factory "Following", [
  "Restangular"
  "RestangularPlus"
  (Restangular, RestangularPlus) ->
    Restangular.extendModel "following", (self) ->
      
      self.getInteractions = () ->
        self.interactions 

      self.getInteractionsIn = () ->
        self.interactions_in

      self.entity = ->
        if self.entity_type == "User"
          RestangularPlus.getModel("users", self.connect_to_id)
        else if self.entity_type == "Business"
          RestangularPlus.getModel("businesses", self.connect_to_id)

      return self
]