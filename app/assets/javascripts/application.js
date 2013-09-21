// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require angular
//= require quips_index

$(function() { $('.datepicker').datepicker(); });
/* this allows us to pass in HTML tags to autocomplete. Without this they get escaped */
$[ "ui" ][ "autocomplete" ].prototype["_renderItem"] = function( ul, item) {
return $( "<li></li>" ) 
  .data( "item.autocomplete", item )
  .append( $( "<a></a>" ).html( item.label ) )
  .appendTo( ul );
};

$(function() {
  $('.navbar-search .search-query').autocomplete({
    source: '/quips/ajax_autocomplete',
    position: {my: 'right top', at: 'right bottom'},
    select: function(e, ui) { window.location = "/quips/"+ui.item.value; return false;}
  });
});

//voting
$(function() {
  function disable_voting() {
    $('#upvote').html('');
    $('#downvote').html('');
  }
  $('#upvote').bind('ajax:loading', function() { disable_voting(); });
  $('#upvote').bind('ajax:complete', function(data) { $('#votes').html(data); });
});
