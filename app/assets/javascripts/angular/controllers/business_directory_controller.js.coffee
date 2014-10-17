angular.module("NM").controller "BusinessController", [
  "$scope"
  "Business"
  ($scope, Business) ->
    $scope.businesses = []
    $scope.businessList = []
    $scope.query = null
    $scope.searching = false
    $scope.engine = new Bloodhound(
         name: "typeaheads"
         remote:
           url: "/business_search/index?q=%QUERY"

         datumTokenizer: (d) ->
           d

         queryTokenizer: (d) ->
           d
       )
    $scope.randomClick = (bus)->
      # alert JSON.stringify bus
      window.location.href = bus.uri
    $scope.engine.initialize()
    Business.query().then ((results) ->
      $scope.businesses = results["businesses"]
      # alert JSON.stringify results["businesses"]
      $scope.searching = false
      return
    ), (error) ->
      
      $scope.searching = false
   

    $scope.submit = () ->
      $scope.engine.get $scope.query, (suggestions) ->
        $scope.businessList = suggestions[0]
        # alert JSON.stringify $scope.businessList
        $scope.$apply()
#
    #
     #Find a single book and update it
    #Book.get(1234).then (book) ->
      #book.lastViewed = new Date()
      #book.update()
      #return
#
    #
     # Create a book and save it
    #new Book(
      #title: "Gardens of the Moon"
      #author: "Steven Erikson"
      #isbn: "0-553-81957-7"
    #).create()
]