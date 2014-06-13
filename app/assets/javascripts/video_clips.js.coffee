# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

###

jQuery ->
  # Ajax search on submit
  $('#video_clips_search').submit( ->
    $.get(this.action, $(this).serialize(), null, 'script')
    false
  )

  # Ajax search on keyup
  $('#video_clips_search input').keyup( ->
    $.get($("#video_clips_search").attr("action"), $("#video_clips_search").serialize(), null, 'script')
    false
  )
###



