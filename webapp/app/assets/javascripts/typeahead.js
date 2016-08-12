function initTypeahead(remoteUrl, itemUrl, suggestionClickHandler) {
  "use strict";

  function defaultSuggestionClickHandler(event, datum, name){
    var identifier = datum.slug || datum.uid || datum.id;
    window.location.href = itemUrl + identifier;
  }

  suggestionClickHandler = suggestionClickHandler || defaultSuggestionClickHandler;

  // instantiate the typeahead UI
  var searchSelector = 'input.typeahead';
  $(searchSelector).typeahead({
    minLength: 0,
    highlight: true
  }, {
    displayKey: 'name',
    source: function(query, syncResults, asyncResults) {
      $.get(remoteUrl + '?query=' + query, function(data) {
        asyncResults(data);
      });
    }
  });

  // this is the event that is fired when a user clicks on a suggestion
  $(searchSelector).bind('typeahead:selected', suggestionClickHandler);
}
