# Main script
$(document).on 'ready page:load page:restore', ->
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
  # dropzone for new task
  $('#new_task').dropzone
    maxFilesize: 2
    addRemoveLinks: true
    acceptedFiles: ".jpg, .jpeg, .png, .gif"
    uploadMultiple: true,
    autoProcessQueue: false,
    parallelUploads: 100,
    maxFiles: 100,
    previewsContainer: ".dropzone-previews",
    clickable: '.dropzone-clickable'
    init: () ->
      myDropzone = this
      # create loading button indicator
      laddaButt = Ladda.create(this.element.querySelector('button[type=submit]'))
      console.log(myDropzone)

      $(this.element).submit (e) ->
        laddaButt.start()
        # Only submit by dropzone if have no files upoaded
        if myDropzone.files.length != 0
          e.preventDefault()
          e.stopPropagation()
          # Disable all element in the form
          disableForm(myDropzone.element, true)
          # Start upload the data
          myDropzone.processQueue()

      this.on 'sendingmultiple', ->
        console.log('sending images')
        myDropzone.disable()

      this.on 'successmultiple', (files, response) ->
        # Redirect to the work that the newly created task belongs to
        window.location = response.redirect_url

      this.on 'errormultiple', (files, response) ->
        # Enable all element in the form
        disableForm(myDropzone.element, false)
        myDropzone.enable()
        laddaButt.stop()

  # Function to disable and enable form field
  disableForm = (el, state) ->
    $(el).find('input,textarea,button').attr('disabled', state)


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
