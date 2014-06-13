# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

###
jQuery ->

  # Ajax search on submit
  $('#people_search').submit( ->
    $.get(this.action, $(this).serialize(), null, 'script')
    false
  )

  # Ajax search on keyup
  $('#people_search input').keyup( ->
    $.get($("#people_search").attr("action"), $("#people_search").serialize(), null, 'script')
    false
  )

  $('#people th a, #people .pagination a').live("click", ->
    $.getScript(this.href)
    false
  )
###


$(document).ready ->

  $('#comments_div th a, #comments_div .pagination a').attr('data-remote', 'true');

  $('#new_comment_form_div').submit( ->
    $.get($('#new_comment_form_div').attr("action"), $(this).serialize(), null, 'script')
    false
  )

  # Ajax comment on submit
  $('#new_comment_form').submit( ->
    $.post($('#new_comment_form').attr("action"), $(this).serialize(), null, 'script')
    false
  )

  # Ajax search on submit
  $('#video_clips_search').submit( ->
    $.get(this.action, $(this).serialize(), null, 'script')
    false
  )

  # Ajax search on submit
  $('#video_clips_unavailable_search').submit( ->
    $.get(this.action, $(this).serialize(), null, 'script')
    false
  )

  # Ajax search on keyup
  $('#video_clips_unavailable_search input').keyup( ->
    $.get($("#video_clips_unavailable_search").attr("action"), $("#video_clips_unavailable_search").serialize(), null, 'script')
    false
  )

  # Ajax search on keyup
  $('#video_clips_search input').keyup( ->
    $.get($("#video_clips_search").attr("action"), $("#video_clips_search").serialize(), null, 'script')
    false
  )

  # Ajax search on submit
  $('#people_search').submit( ->
    $.get(this.action, $(this).serialize(), null, 'script')
    false
  )

  # Ajax search on keyup
  $('#people_search input').keyup( ->
    $.get($("#people_search").attr("action"), $("#people_search").serialize(), null, 'script')
    false
  )








