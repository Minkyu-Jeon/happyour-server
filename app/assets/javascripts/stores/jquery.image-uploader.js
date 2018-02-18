(function($, Dropzone) {
  Dropzone.autoDiscover = false;

  function imageUploader($imageUploader, formOptions) {
    this.images = formOptions.images || [];
    this.imageWrapper = formOptions.imageWrapper || "";
    this.removedImageWrapper = formOptions.removedImageWrapper || "";
    this.imageDropzone = formOptions.imageDropzone
    this.$imageUploader = $imageUploader;
    this.formName = formOptions.formName;
    this.formAttribute = formOptions.formAttribute;
    this.formWrapper = "#"+this.formName + "-wrapper"
    this.combineFormName = this.formName + this.formAttribute
  }

  imageUploader.prototype.initialize = function() {
    var self = this;
    self.$imageUploader.wrap("<div id='"+this.formWrapper.slice(1)+"'></div>");

    $(this.formWrapper).prepend("<div class='"+ this.removedImageWrapper.slice(1) +" clearfix m-bottom-lg'></div>");
    $(this.formWrapper).prepend("<div class='"+ this.imageWrapper.slice(1) +" row'></div>");

    var $dropzone = $(this.formWrapper).find(this.imageDropzone)
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
      complete: completeUpload.bind(this),
      removedfile: removedFile.bind(this)
    }

    this.myDropzone = new Dropzone(this.formWrapper + " " +this.imageDropzone, dropzoneOptions);
    this.renderServerImage();

    $(this.formWrapper).find(this.imageWrapper).on("click", ".card-body button", function(e) {
      var direction = $(this).data("direction")
      var $displayOrder = $(this).closest('.card-body').find(".display-order")
      var displayOrder = $displayOrder.val()

      var item = self.findItemByDisplayOrder(displayOrder);
      var image = item["item"];
      var itemIndex = item["index"];
      
      if ( direction == "left" ) {
        if ( displayOrder == 1 ) return;
        swapImage(self.images[itemIndex], self.images[itemIndex - 1]);
      } else if ( direction == "right" ) {
        if ( displayOrder == self.images.length ) return;
        swapImage(self.images[itemIndex], self.images[itemIndex + 1]);
      }
      self.renderImages()
    });
  }

  imageUploader.prototype.renderServerImage = function() {
    var dZone = this.myDropzone;
    this.images.forEach(function(el, idx, arr) {
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
    response["display_order"] = this.images.length + 1
    this.images.push(response)
    this.renderImages()
  }

  var removedFile = function(file) {
    var response = null

    if ( file.xhr == undefined ) {
      this.removeImage(file.name, true)
    } else {
      response = JSON.parse(file.xhr.response)
      this.removeImage("/uploads/tmp/"+response["filename_cache"])
    }
    $(file.previewElement).remove()
    this.renderImages()
  }

  imageUploader.prototype.removeImage = function(filename, isServerFile) {
    var i = 0;
    for ( var i = 0; i < this.images.length; i ++ ) {
      var el = this.images[i];
      if ( el["image_url"] == filename ) {
        if ( isServerFile ) {
          var html = "<input type='hidden' name='"+this.combineFormName+"[id]' value='"+el.id+"'>";
          html += "<input type='hidden' name='"+this.combineFormName+"[_destroy]' value='1'>"
          $(this.formWrapper).find(this.removedImageWrapper).append(html)
        }

        this.images.splice(i, 1);
        break;
      }
    }
    this.reOrderImage()
  }

  imageUploader.prototype.reOrderImage = function() {
    for ( var i = 0; i < this.images.length; i ++ ) {
      this.images[i].display_order = i+1
    }
  }

  imageUploader.prototype.renderImages = function() {
    var $wrapper = $(this.formWrapper).find(this.imageWrapper);
    $wrapper.html("")

    this.images.sort(sortByDisplayorder).forEach(function(el, index, array) {
      var html = ""
      html += "<div class='col-3'>"
      html += "<div class='card'>"
      html += "<img class='card-img-top' src='"+el.image_url+"'>"
      html += "<div class='card-body text-center'>"
      html += "<input type='hidden' name='"+this.combineFormName+"[id]' value='"+ (el.id || "") +"'>"
      if ( el.filename_cache != undefined ) {
        html += "<input type='hidden' name='"+this.combineFormName+"[image_cache]'  class='form-control' value='"+el.filename_cache+"'>"
      }
      html += "<input type='hidden' name='"+this.combineFormName+"[display_order]' class='display-order' value='"+el.display_order+"'>"
      html += "<button type='button' data-direction='left' class='btn btn-sm btn-primary m-right-sm'>&lt;</button>"
      html += "<button type='button' data-direction='right' class='btn btn-sm btn-primary'>&gt;</button>"
      html += "</div>"
      html += "</div>"
      html += "</div>"
      $wrapper.append(html)
    }.bind(this));
  }

  imageUploader.prototype.findItemByDisplayOrder = function(order) {
    var result = {}
    for ( var i = 0; i < this.images.length; i ++ ) {
      var el = this.images[i];
      if ( el.display_order == order ) {
        result["item"] = el;
        result["index"] = i
        break;
      }
    }
    return result;
  }

  var sortByDisplayorder = function(a, b) { return a.display_order - b.display_order }

  var swapImage = function(a, b) {
    var tmp = a;
    a = b;
    b = tmp
    tmp = a.display_order
    a.display_order = b.display_order
    b.display_order = tmp
  }

  $.fn.imageUploader = function(options) {
    var formOptions = $.extend({}, $.fn.imageUploader.defaultOptions, options)
    formOptions.images = eval("("+JSON.stringify(formOptions.images)+")");

    var uploader = new imageUploader($(this), formOptions);

    return $(this).each(function() {
      uploader.initialize();
      uploader.renderImages()
    });
  }

  $.fn.imageUploader.defaultOptions = {
    imageDropzone: "#store-image-form",
    imageWrapper: ".store-images",
    removedImageWrapper: ".removed-image",
    autoDiscover: false
  }
})(window.jQuery, window.Dropzone);
