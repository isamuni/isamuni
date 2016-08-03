

function initTypeahead(remoteUrl, itemUrl, suggestionClickHandler) {
  "use strict";

  function defaultSuggestionClickHandler(event, datum, name){
    var identifier = datum.slug || datum.uid || datum.id;
    window.location.href = itemUrl + identifier;
  }

  suggestionClickHandler = suggestionClickHandler || defaultSuggestionClickHandler;

  var searchSelector = 'input.typeahead';

  var bloodhound = new Bloodhound({
    remote: {
      url: remoteUrl + '?query=%QUERY',
      wildcard: '%QUERY'
    },
    datumTokenizer: function(d) {
      return Bloodhound.tokenizers.whitespace(d.name);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace
  });

  // initialize the bloodhound suggestion engine
  bloodhound.initialize();

  // instantiate the typeahead UI
  $(searchSelector).typeahead({
    minLength: 0,
    highlight: true
  }, {
    displayKey: 'name',
    source: bloodhound.ttAdapter(),
  });

  // this is the event that is fired when a user clicks on a suggestion
  $(searchSelector).bind('typeahead:selected', suggestionClickHandler);
}
