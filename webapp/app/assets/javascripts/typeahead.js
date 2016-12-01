/* global $ */

function initTypeahead(remoteUrl, itemUrl, showPicture, suggestionClickHandler) {
    "use strict";

    function defaultSuggestionClickHandler(event, datum, name) {
        var identifier = datum.slug || datum.uid || datum.id;
        // Enable line of code below to allow clickable suggestions to redirect to itemUrl
        window.location.href = itemUrl + identifier;
    }

    showPicture = showPicture || false;
    suggestionClickHandler = suggestionClickHandler || defaultSuggestionClickHandler;

    // instantiate the typeahead UI
    var searchSelector = 'input.typeahead';
    $(searchSelector).typeahead('destroy');
    $(searchSelector).typeahead({
        minLength: 0,
        highlight: true
    }, {
        displayKey: 'name',
        source: function(query, syncResults, asyncResults) {
            $.get(remoteUrl + '?query=' + query, function(data) {
                asyncResults(data);
            });
        },
        templates: {
            empty: '', //optional
            suggestion: function(data) {
                if (showPicture) {
                    return '<div><img src="' + data.thumbnail + '"/>' +
                        ' ' + data.name + '</div>';
                } else {
                    return '<div>' + data.name + '</div>';
                }
            }
        }
    });

    // this is the event that is fired when a user clicks on a suggestion
    $(searchSelector).bind('typeahead:selected', suggestionClickHandler);
}
