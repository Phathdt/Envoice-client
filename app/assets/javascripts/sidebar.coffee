# $(document).ready ->
#   $('.sidebar-submenu').slideUp 200

#   $('.navbar-nav.sidebar .nav-item > a').click ->
#     false

#   $('.sidebar .nav-item > a').click ->
#     $('.sidebar-submenu').slideUp 200
#     active = $(this).parent().hasClass 'active'
#     $('.sidebar .nav-item').removeClass 'active'
#     $('.sidebar .nav-link').removeClass 'active'

#     unless active
#       $('.sidebar .nav-item').removeClass 'active'
#       $('.sidebar .nav-link').removeClass 'active'
#       $(this).addClass 'active'
#       $(this).next('.sidebar-submenu').slideDown 200
#       $(this).parent().addClass 'active'
