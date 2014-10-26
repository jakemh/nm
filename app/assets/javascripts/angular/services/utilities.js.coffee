App.factory "Utilities", [
    "$sce"
    ($sce) ->
      trustAsHtml: (value) ->
        return $sce.trustAsHtml(value);




]
