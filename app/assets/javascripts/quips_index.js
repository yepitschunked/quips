var quips_scroller = {};
$(function() {
  $('#search_box').autocomplete({
    source: '/quips/ajax_autocomplete'
  });
  $('#search_box').focus(function(e) {
      $(this).css({color: "black"});
      $(this).value="";
  });
});

// infinite scrolling, https://github.com/amatsuda/kaminari/wiki/How-To:-Create-Infinite-Scrolling-with-jQuery
$(function() {
  quips_scroller['page'] = 1;
  quips_scroller['loading'] = false;
  function nearBottomOfPage() {
    return $(window).scrollTop() > $(document).height() - $(window).height() - 200;
  }

  function loadNextPage() {
    if(quips_scroller['loading']) 
      return;
    if(nearBottomOfPage()) {
      quips_scroller['loading'] = true;
      quips_scroller['page']++;
      $.ajax({
        url:'/quips',
        data: {'page': quips_scroller['page']}, 
        success: function() { quips_scroller['loading'] = false; },
        dataType: 'script'});
    }
  }
  setInterval(loadNextPage, 200);
});
