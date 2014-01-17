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
