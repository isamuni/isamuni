var ready;
ready = function() {
  var searchSelector = 'input.typeahead';
    var bloodhound = new Bloodhound({
      remote: {url: "/users/typeahead?query=%QUERY"},
      datumTokenizer: function(d) { 
              return Bloodhound.tokenizers.whitespace(d.name); },
      queryTokenizer: Bloodhound.tokenizers.whitespace
});

// initialize the bloodhound suggestion engine
bloodhound.initialize();

// instantiate the typeahead UI
$(searchSelector).typeahead(null, {
  displayKey: 'name',
  source: bloodhound.ttAdapter()
});

// this is the event that is fired when a user clicks on a suggestion
$(searchSelector).bind('typeahead:selected', function(event, datum, name) {
  //console.debug('Suggestion clicked:', event, datum, name);
  window.location.href = '/users/' + datum.id;
});
}

$(document).ready(ready);
$(document).on('page:load', ready);
