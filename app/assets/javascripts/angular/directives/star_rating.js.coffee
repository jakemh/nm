angular.module("NM").directive "starRating", ->
  restrict: "A"
  #&#9733
  template: "<ul ng-class=\"{'feed__entry-input--error' : ratingValue == 0 && validateStars}\" class='rating'>" + "  <li ng-repeat='star in stars' ng-class='star' ng-click='toggle($index)'>" + "    <i class='fa fa-star'></i>" + "  </li>" + "</ul>"
  scope:
    ratingValue: "="
    max: "="
    onRatingSelected: "&"
    validateStars: "="
    
  link: (scope, elem, attrs) ->
    updateStars = ->

      scope.stars = []
      i = 0

      while i < scope.max
        scope.stars.push filled: i < scope.ratingValue
        i++

    scope.toggle = (index) ->
      scope.ratingValue = index + 1
      scope.onRatingSelected rating: index + 1
      return

    scope.$watch "ratingValue", (oldVal, newVal) ->
      updateStars() 
      return

    updateStars()
    return