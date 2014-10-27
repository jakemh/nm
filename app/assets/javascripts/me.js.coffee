ready = undefined
ready = ->


  $vartypeahead = $("#query")
  engine = new Bloodhound(
    name: "typeaheads"
    remote:
      url: "/auto_complete?q=%QUERY"
      filter: (response) ->
        response.me 
        
    datumTokenizer: (d) ->
      d

    queryTokenizer: (d) ->
      d
  )
  engine.initialize()

  $vartypeahead.typeahead {minLength: 1, highlight: true},
    # displayKey: "name"
    source: engine.ttAdapter()
    templates:
      suggestion: _.template('<a href="<%=uri%>"><%=name%></a>')
  
 

    
$(document).ready ready
$(document).on "page:load", ready

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

