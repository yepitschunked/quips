// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//= require jquery
//= require jquery_ujs

//voting
$(function() {
  function disable_voting() {
    $('#upvote').html('');
    $('#downvote').html('');
  }

  $('#upvote').bind('ajax:loading', function() { disable_voting(); });
  $('#upvote').bind('ajax:complete', function(data) { $('#votes').html(data); });
  $('#search_box').focus(function(e) {
      $(this).css({color: "black"});
      $(this).value="";
  });
});
