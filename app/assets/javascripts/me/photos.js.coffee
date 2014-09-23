window.bindUpload = (form) ->
  $(".photo").fileupload
    dataType: "script"
    url: form.attr('action')
    add: (e, data) ->
      data.context = $("<p/>").text("Uploading...").appendTo($(".main__photo "))
      data.submit()
    done: (e, data) ->

ready = undefined
ready = ->

  fileUploadErrors =
    maxFileSize: "File is too big"
    minFileSize: "File is too small"
    acceptFileTypes: "Filetype not allowed"
    maxNumberOfFiles: "Max number of files exceeded"
    uploadedBytes: "Uploaded bytes exceed file size"
    emptyResult: "Empty file upload result"

    # Initialize the jQuery File Upload widget:
  form = $("#form-imageupload")
  
        
  window.bindUpload(form)    


      # $.each data.result.files, (index, file) ->
      #   $(".main__photo ").empty()
      #   $("<img src= " + file + ">").text(file.name).appendTo $(".main__photo ")

  
  # 
  # Load existing files:
  # $.getJSON $("#fileupload").prop("action"), (files) ->
  #   fu = $("#fileupload").data("blueimpFileupload")
  #   alert fu
  #   template = undefined
  #   fu._adjustMaxNumberOfFiles -files.length
  #   console.log files
  #   template = fu._renderDownload(files).appendTo($("#fileupload .files"))
    
  #   # Force reflow:
  #   fu._reflow = fu._transition and template.length and template[0].offsetWidth
  #   template.addClass "in"
  #   $("#loading").remove()
  #   return


$(document).ready ready
$(document).on "page:load", ready


