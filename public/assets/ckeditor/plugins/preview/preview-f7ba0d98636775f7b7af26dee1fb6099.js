// Angular Rails Template
// source: /Users/jh/.rvm/gems/ruby-2.1.1/gems/ckeditor-4.0.11/vendor/assets/javascripts/ckeditor/plugins/preview/preview.html

angular.module("templates").run(["$templateCache", function($templateCache) {
  $templateCache.put("ckeditor/plugins/preview/preview.html", "<script>\n\nvar doc = document;\ndoc.open();\ndoc.write( window.opener._cke_htmlToLoad );\ndoc.close();\n\ndelete window.opener._cke_htmlToLoad;\n\n</script>")
}]);

