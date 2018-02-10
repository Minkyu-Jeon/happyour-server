(function($, Dropzone) {

  var initializeDropzone = function(dropzone, storeImages) {
    var $dropzone = $(dropzone)
    var paramName = $dropzone.find("input[type='file']").attr("name") || "image"
    var url = $dropzone.data("url") || "/store_images";
    console.log(url)
    var dropzoneOptions = {
      url: url,
      paramName: paramName,
      acceptedFiles: "image/*",
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      complete: completeUpload
    }
    var myDropzone = new Dropzone(dropzone, dropzoneOptions);
  }

  var completeUpload = function(file) {
    var response = JSON.parse(file.xhr.response)
  }

  $.fn.storeForm = function(options) {
    var formOptions = $.extend({}, $.fn.storeForm.defaultOptions, options)
    Dropzone.autoDiscover = false;
    return $(this).each(function() {
      initializeDropzone(formOptions.storeImageDropzone, formOptions.storeImages);
    });
  }

  $.fn.storeForm.defaultOptions = {
    storeImageDropzone: "#store-image-form"
  }
})(window.jQuery, window.Dropzone);
