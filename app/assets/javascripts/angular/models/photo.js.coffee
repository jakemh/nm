# angular.module("NM").factory "Photo", [
#   "$q"
#   "Restangular"
#   "RestangularPlus"
#   "RestEntity"
#   ($q, Restangular, RestangularPlus, RestEntity) ->
#     Restangular.extendModel "photos", (self) ->
#       angular.extend self, RestangularPlus
#       angular.extend self, RestEntity

#       return self
# ]

angular.module("NM").factory "ProfilePhoto", [
  "$q"
  "Restangular"
  "RestangularPlus"
  "RestEntity"
  ($q, Restangular, RestangularPlus, RestEntity) ->
    Restangular.extendModel "profile_photos", (self) ->
      angular.extend self, RestangularPlus
      # angular.extend self, RestEntity

      return self
]

angular.module("NM").factory "CoverPhoto", [
  "$q"
  "Restangular"
  "RestangularPlus"
  "RestEntity"
  ($q, Restangular, RestangularPlus, RestEntity) ->
    Restangular.extendModel "cover_photos", (self) ->
      angular.extend self, RestangularPlus
      # angular.extend self, RestEntity

      return self
]