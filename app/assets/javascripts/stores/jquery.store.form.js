(function($, Dropzone) {
  var storeImages = []
  var storeImageWrapper = "";
  var removedImageWrapper = "";

  var initializeDropzone = function(dropzone, storeImages) {
    var $dropzone = $(dropzone)
    var paramName = $dropzone.find("input[type='file']").attr("name") || "image"
    var url = $dropzone.data("url") || "/store_images";

    var dropzoneOptions = {
      url: url,
      paramName: paramName,
      acceptedFiles: "image/*",
      addRemoveLinks: true,
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      init: renderServerImage,
      complete: completeUpload,
      removedfile: removedFile
    }
    var myDropzone = new Dropzone(dropzone, dropzoneOptions);
  }

  var renderServerImage = function() {
    var dZone = this;
    storeImages.forEach(function(el, idx, arr) {
      var image = {
        name: el.image_url,
        size: 0
      }
      dZone.emit("addedfile", image)
      dZone.emit("thumbnail", image, el.image_url)
    })
  }

  var completeUpload = function(file) {
    var response = JSON.parse(file.xhr.response)
    response["image_url"] = "/uploads/tmp/"+response["filename_cache"]
    response["display_order"] = storeImages.length + 1
    storeImages.push(response)
    renderStoreImages()
  }

  var removedFile = function(file) {
    var response = null

    if ( file.xhr == undefined ) {
      removeImage(file.name, true)
    } else {
      response = JSON.parse(file.xhr.response)
      removeImage("/uploads/tmp/"+response["filename_cache"])
    }
    $(file.previewElement).remove()
    renderStoreImages()
  }

  var removeImage = function(filename, isServerFile) {
    var i = 0;
    for ( var i = 0; i < storeImages.length; i ++ ) {
      var el = storeImages[i];
      if ( el["image_url"] == filename ) {
        if ( isServerFile ) {
          var html = "<input type='hidden' name='store[store_images_attributes][][id]' value='"+el.id+"'>";
          html += "<input type='hidden' name='store[store_images_attributes][][_destroy]' value='1'>"
          $(removedImageWrapper).append(html)
        }

        storeImages.splice(i, 1);
        break;
      }
    }
    reOrderImage()
  }

  var reOrderImage = function() {
    for ( var i = 0; i < storeImages.length; i ++ ) {
      storeImages[i].display_order = i+1
    }
  }

  var sortByDisplayorder = function(a, b) {
    return a.display_order - b.display_order
  }

  var renderStoreImages = function() {
    var $wrapper = $(storeImageWrapper);
    $wrapper.html("")

    storeImages.sort(sortByDisplayorder).forEach(function(el, index, array) {
      console.log(JSON.stringify(el))
      var html = ""
      html += "<div class='col-3'>"
      html += "<div class='card'>"
      html += "<img class='card-img-top' src='"+el.image_url+"'>"
      html += "<div class='card-body text-center'>"
      html += "<input type='hidden' name='store[store_images_attributes][][id]' value='"+ (el.id || "") +"'>"
      if ( el.filename_cache != undefined ) {
        html += "<input type='hidden' name='store[store_images_attributes][][image_cache]'  class='form-control' value='"+el.filename_cache+"'>"
      }
      html += "<input type='hidden' name='store[store_images_attributes][][display_order]' class='display-order' value='"+el.display_order+"'>"
      html += "<button type='button' data-direction='left' class='btn btn-sm btn-primary m-right-sm'>&lt;</button>"
      html += "<button type='button' data-direction='right' class='btn btn-sm btn-primary'>&gt;</button>"
      html += "</div>"
      html += "</div>"
      html += "</div>"
      $wrapper.append(html)
    });
  }

  var findItemByDisplayOrder = function(order) {
    var result = {}
    for ( var i = 0; i < storeImages.length; i ++ ) {
      var el = storeImages[i];
      if ( el.display_order == order ) {
        result["item"] = el;
        result["index"] = i
        break;
      }
    }
    return result;
  }

  var swapImage = function(a, b) {
    var tmp = a;
    a = b;
    b = tmp
    tmp = a.display_order
    a.display_order = b.display_order
    b.display_order = tmp
  }

  $.fn.storeForm = function(options) {
    var formOptions = $.extend({}, $.fn.storeForm.defaultOptions, options)
    storeImages = eval("("+JSON.stringify(formOptions.storeImages)+")");
    storeImageWrapper = formOptions.storeImageWrapper
    removedImageWrapper = formOptions.removedImageWrapper

    Dropzone.autoDiscover = false;
    $(storeImageWrapper).on("click", ".card-body button", function(e) {
      var direction = $(this).data("direction")
      var $displayOrder = $(this).closest('.card-body').find(".display-order")
      var displayOrder = $displayOrder.val()

      var item = findItemByDisplayOrder(displayOrder);
      var image = item["item"];
      var itemIndex = item["index"];

      if ( direction == "left" ) {
        if ( displayOrder == 1 ) return;
        swapImage(storeImages[itemIndex], storeImages[itemIndex - 1]);
      } else if ( direction == "right" ) {
        if ( displayOrder == storeImages.length ) return;
        swapImage(storeImages[itemIndex], storeImages[itemIndex + 1]);
      }
      renderStoreImages()
    });
    return $(this).each(function() {
      initializeDropzone(formOptions.storeImageDropzone, storeImages);
      renderStoreImages()
    });
  }

  $.fn.storeForm.defaultOptions = {
    storeImageDropzone: "#store-image-form",
    storeImageWrapper: "#store-images",
    removedImageWrapper: "#removed-image"
  }
})(window.jQuery, window.Dropzone);
