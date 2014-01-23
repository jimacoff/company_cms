# Main script
$(document).on 'ready page:load page:restore', ->
  # Alertify all alert
  $('.alert').alert()

  # Toggle sidebar when in admin
  $('#menu-toggle-admin').click (e) ->
    e.preventDefault()
    $('#wrapper').toggleClass('active')

  # Dropzone configuration for add iamges
  Dropzone.autoDiscover = false

  # Initial dropzone funciton for new task
  initDropZone = (el) ->
    $(el).dropzone
      maxFilesize: 2
      addRemoveLinks: true
      acceptedFiles: ".jpg, .jpeg, .png, .gif"
      uploadMultiple: true,
      autoProcessQueue: false,
      parallelUploads: 100,
      maxFiles: 100,
      previewsContainer: ".dropzone-previews",
      clickable: '.dropzone-clickable'
      init: ->
        myDropzone = this
        # create loading button indicator
        laddaButt = Ladda.create(this.element.querySelector('button[type=submit]'))
        $submitButt = $(this.element).find('button[type=submit]')

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

        this.on 'error', ->
          # Disable the submit button on error
          $submitButt.attr('disabled', true)

        this.on 'addedfile', ->
          if areFilesValid(myDropzone.files)
            $submitButt.attr('disabled', false)

        this.on 'removedfile', ->
          if areFilesValid(myDropzone.files)
            $submitButt.attr('disabled', false)

        this.on 'sendingmultiple', ->
          console.log('sending images')

        this.on 'successmultiple', (files, response) ->
          # Redirect to the work that the newly created task belongs to
          window.location = response.redirect_url

        this.on 'errormultiple', (files, response) ->
          laddaButt.stop()
          # Enable all element in the form, except the submit button
          disableForm(myDropzone.element, false)
          $submitButt.attr('disabled', true)

  # Function to disable and enable form field
  disableForm = (el, state) ->
    $(el).find('input,textarea,button').attr('disabled', state)

  # Function to check file error
  areFilesValid = (files) ->
    errorFiles = (file for file in files when file.status == 'error')
    console.log(errorFiles)
    !errorFiles? || errorFiles.length == 0

  # Init dropzone for those forms
  initDropZone('#new_task')
  initDropZone('.edit_task')

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
    $('#post-info-modal').modal(remote: $(this).attr('href'))

  # Showing task modal
  $('.task-list .task-info').click (e) ->
    e.preventDefault()
    $('#task-info-modal').modal(remote: $(this).attr('href'))

  # Function to display image lightbox using color box
  showImageGallery = (el, opts) ->
    defaultOpts = { rel: 'gal', maxWidth: '50%', maxHeight: '80%' }
    opts = opts || defaultOpts
    $(el).colorbox opts

  # Attach the image gallery to the task info modal
  $('#task-info-modal').on 'shown.bs.modal', (e) ->
    $('.image-gallery .task-image').colorbox
    showImageGallery('.image-gallery .task-image')

  # Image lightbox when show edit tasks
  showImageGallery('.image-gallery .task-image')

  # Handle delete a image
  $('.image-delete').on 'click', (e) ->
    e.preventDefault()
    url = $(this).attr('href')
    imageId = $(this).data('id')
    $.ajax
      url: url,
      type: 'DELETE',
      dataType: 'json'
      success: (res) ->
        if res.status == 1
          $('#container_' + imageId).remove()
        else
          alert('Error Deleting Image!!!')


  # Handle bootstrap modal glitch
  $('body').on 'hidden.bs.modal', '.modal', ->
    $(this).removeData('bs.modal')
