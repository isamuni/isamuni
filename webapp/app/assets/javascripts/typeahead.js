function initTypeahead(remoteUrl, itemUrl) {
  "use strict";

  var searchSelector = 'input.typeahead';

  var bloodhound = new Bloodhound({
    remote: {
      url: remoteUrl
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
  $(searchSelector).bind('typeahead:selected', function(event, datum, name) {
    //console.debug('Suggestion clicked:', event, datum, name);
    window.location.href = itemUrl + datum.slug;
  });
}
