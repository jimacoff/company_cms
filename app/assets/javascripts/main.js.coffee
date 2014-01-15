# Main script
$(document).on 'ready page:load page:restore', ->
  # For display side bar when in main page
  $("#menu-toggle").click (e) ->
    e.preventDefault()
    $("#sidebar-wrapper").toggleClass("active")

  $("#menu-close").click (e) ->
    e.preventDefault()
    $("#sidebar-wrapper").toggleClass("active")

  # Smooth transition between hook
  $('a[href*=#]:not([href=#])').click ->
    if location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') or location.hostname == this.hostname
      target = $(this.hash)
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']')
      if target.length
        $('html,body').animate({
          scrollTop: target.offset().top
        }, 1000)

        return false

  # Alertify all alert
  $('.alert').alert()

  # Toggle sidebar when in admin
  $('#menu-toggle-admin').click (e) ->
    e.preventDefault()
    $('#wrapper').toggleClass('active')

  # Gallery popup for work images
  $('.popup-gallery .work-image').magnificPopup
    type: 'image'
    mainClass: 'mfp-with-zoom mfp-img-mobile'
    gallery:
      enabled: true
    image:
      titleSrc: (item) ->
        # get the delete link for the image
        url = item.el.data('url')
        # create delete button with delete link
        deleteButt = '<a href="' + url + '"class="btn btn-sm btn-danger image-delete" data-method="delete" data-confirm="Your sure?" ref="nofollow">Delete</a>'

  # Dropzone configuration for add iamges
  Dropzone.autoDiscover = false
  $('#work-images-dropzone').dropzone
    maxFilesize: 10
    addRemoveLinks: true
    acceptedFiles: ".jpg, .jpeg, .png, .gif"
    uploadMultiple: false
    autoProcessQueue: false,
    init: () ->
      $submitButton = $(".add-images-zone #submit-all")
      myDropzone = this
      hasError = false

      # Add event handler for close the alert
      $('.alert .continue-images').on 'click', (e) ->
        e.preventDefault()
        $('.alert').fadeOut()
        $submitButton.attr('disabled', false)
        $submitButton.fadeIn()

      # When submit click, begin upload images process
      $submitButton.on "click", ->
        # start process image queue
        myDropzone.processQueue()
        $(this).attr('disabled', 'disabled')

      this.on "addedfile", ->
        $submitButton.attr('disabled', false)

      this.on "error", (e, msg, xhr)->
        $submitButton.attr('disabled', 'disabled')
        hasError = true

      # On complete all upload, display messages
      this.on "complete", ->
        if this.getQueuedFiles().length == 0 && this.getUploadingFiles().length == 0
          $submitButton.hide()
          if hasError
            $('.add-images-zone .alert-danger').fadeIn()
          else
            $('.add-images-zone .alert-success').fadeIn()
        else
          # Continue to process the image queue
          myDropzone.processQueue()


  # Contact form handling (parsley)
  $('#contact-form #new_message').parsley()
  $('#contact-form #new_message').submit (e) ->
    e.preventDefault()
    that = this

    # Only submit the form if client side validation is valid
    if $(this).parsley('isValid')
      url = $(this).attr('action')
      data = $(this).serialize()
      $.ajax
        type: 'POST',
        url: url,
        data: data,
        dataType: 'json',
        success: (res) ->
          if res.status == 1
            $(that).fadeOut ->
              $('#contact-form .alert-success').fadeIn()


  # Function to upload file for post content
  uploadFile = (file, cb) ->
    url = $('#post-image-path').val()
    data = new FormData()
    data.append('file', file)
    $.ajax
      type: 'POST'
      url: url,
      data: data,
      cache: false,
      contentType: false,
      processData: false,
      dataType: 'json',
      success: cb

  # Initial summernote for post content editor
  $('#post_content').summernote
    height: 300,
    onImageUpload: (files, editor, welEditable) ->
      # Display the overlay model
      $modal = $('.background-modal')
      $modal.fadeIn()

      # Start to upload the file
      uploadFile files[0], (res) ->
        $modal.fadeOut ->
          if res.status == 1
            editor.insertImage(welEditable, res.url)
          else
            alert res.error


  # Showing post modal
  $('.post-list .post-info').click (e) ->
    e.preventDefault()
    $('#post-info-modal').modal({ remote: $(this).attr('href') })
    $('.model-wide').on 'show.bs.modal', ->
      $(this).find('.modal-dialog').css({
        width:'auto',
        height:'auto',
        'max-height':'100%'
      })

  # Handle bootstrap modal glitch
  $('body').on 'hidden.bs.modal', '.modal', ->
    $(this).removeData('bs.modal')