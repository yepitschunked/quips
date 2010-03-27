var quips_autocompleter = {};
quips_autocompleter.last_query = "";
quips_autocompleter.current_results = [];
quips_autocompleter.completing = true; // should we try to update results upon typing?
quips_autocompleter.results_field = "";
quips_autocompleter.search_field = "";

function highlight_query(search_query, snippet) {
  if(snippet) {
    var re = RegExp("("+RegExp.escape(search_query)+")", "i");
    return snippet.replace(re, "<b>$1</b>");
  }
}
function field_updated(element, value) {
  value = value.toLowerCase();
  if(value.length == 0) {
    $(quips_autocompleter.results_field).hide();
      return;
  }
  if(value.length < 3) {
    update_results(value);
    return;
  }
  // If we have existing results, just filter through them
  var existing_results = quips_autocompleter.current_results.filter(function(s) {
      return s.quip.toLowerCase().include(value);});
  if(existing_results.length > 0){
    quips_autocompleter.current_results = existing_results;
    update_results(value);
    return;
  }
  // Stop searching if we fail and this query
  // is continuing the previous one
  else if(quips_autocompleter.last_query && value.startsWith(quips_autocompleter.last_query) && quips_autocompleter.current_results.length == 0) { 
    return;
  }
  quips_autocompleter.last_query = value;

  new Ajax.Request("/quips/ajax_autocomplete",
      {
      parameters:'query='+value,
      onSuccess: function(transport) {
      quips_autocompleter.current_results = transport.responseJSON;
      update_results(value.escapeHTML());} 
      });
}
function update_results(search_query) {
  if(!quips_autocompleter.completing)
    return;
  if(quips_autocompleter.current_results.length == 0) {
    $(quips_autocompleter.results_field).hide();
    return;
  }
  display = quips_autocompleter.current_results.collect(function(s) {
      lines = s.quip.split('\n');
      var id = s.id;
      if(lines.length > 5) {
        for(var i=0;i<lines.length;i++) {
          if(lines[i].toLowerCase().include(search_query)) {
            start = [0, i-4].max();
            end=[lines.length, i+5].min();
            s = lines.collect(String.escapeHTML).slice(start, end).join("&nbsp;&nbsp;");
            break;
          }
        }
      }
      else
        s = s.quip.escapeHTML().replace(/\n/g, "");

      var node = new Element('div', {'class': 'search_result', 'tabindex': 0});
      node.update('<a href="quips/show/'+id+'">'+highlight_query(search_query.escapeHTML(),s)+'</a>');
      node.observe('mouseover', function(event) {
        $(quips_autocompleter.results_field).current_index = $(quips_autocompleter.results_field).childElements().indexOf(this);
        $(quips_autocompleter.results_field).childElements().invoke('removeClassName', 'selected');
        this.addClassName('selected');});
      return node;

    });
    var resultdiv = $(quips_autocompleter.results_field);

    resultdiv.show();
    resultdiv.update("");
    display.each(function(d) { resultdiv.insert(d);});
    $(quips_autocompleter.results_field).current_index = -1;
    $(quips_autocompleter.results_field).highlightNext = function() {
      var children = $(this).childElements();
      if(this.current_index+1 < children.length) {
        children.each(function(e) { e.removeClassName('selected') });
        this.childElements()[++this.current_index].addClassName('selected');
        $(quips_autocompleter.search_field).value = children[this.current_index].textContent
      }
    }
    $(quips_autocompleter.results_field).highlightPrev = function() {
      var children = $(this).childElements();
      children.each(function(e) { e.removeClassName('selected') });
      if(this.current_index > 0) {
        this.childElements()[--this.current_index].addClassName('selected');
        $(quips_autocompleter.search_field).value = children[this.current_index].textContent
      }
      else
        this.current_index = -1;
    }
}
function create_autocomplete(s, r) {
  quips_autocompleter.search_field = s;
  quips_autocompleter.results_field = r;
  new Form.Element.Observer(quips_autocompleter.search_field, 0.05, field_updated);
  $(quips_autocompleter.search_field).observe('keydown', function(event) {
      quips_autocompleter.completing = false;
      switch(event.keyCode) {
        case Event.KEY_DOWN: 
          $(quips_autocompleter.results_field).highlightNext();
          event.stop();
          break;
        case Event.KEY_UP:
          $(quips_autocompleter.results_field).highlightPrev();
          event.stop();
          break;
        case Event.KEY_RETURN:
          var active_index = [$(quips_autocompleter.results_field).current_index, 0].max();
          window.location = $(quips_autocompleter.results_field).childElements()[active_index].down().href;
          break;
        default:
          quips_autocompleter.completing = true;
        }
    });

    document.observe('click', function(event) {
      $('results').hide();});
}


