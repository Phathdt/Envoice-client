$ ->
  $('input.staff-toggle').change ->
    id = $(this).attr("data-id")
    $.post Routes.toggle_owner_user_path(id), (data, status) ->
