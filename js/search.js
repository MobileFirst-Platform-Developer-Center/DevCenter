'use strict';

var _this = this;

// ELASTICSEARCH
var MFPSEARCH = {
    client: null,
    queryTerm: null,
    body: {},
    pageSize: 10,
    total: 0,
    from: 0,
    getParameterByName: function(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)", "i"),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    },
    executeSearch: function() {
        $("#searchResults").empty();
        $("#searchResults").addClass("loader");
        this.body.from = this.from;

        _this = this;
        this.client.search({
            "body": this.body
        }).then(function(body) {
            console.log(body);
            _this.total = body.hits.total;
            $('#queryTerm').html(_this.total + " results");
            $('#search-input').val(_this.queryTerm);
            var searchResultTemplate = $.templates("#searchResultTemplate");
            $('#searchResults').html('');
            $('html,body').scrollTop(0);

            if (_this.total > 0) {
                $.each(body.hits.hits, function(index, result) {
                    result._source.highlight = result.highlight;
                    $('#searchResults').append(searchResultTemplate.render(result._source));
                });
                $('#searchNextBtn').show();
                $('#searchPreviousBtn').show();
                $('#searchResultsCount').show();
                $('#searchResultsCount').html("Showing page " + ((_this.from / _this.pageSize) + 1) + " out of " + Math.ceil(_this.total / _this.pageSize));
            } else {
                $('#searchResults').html('No results were found. Try refining your search.');
                $('#searchNextBtn').hide();
                $('#searchPreviousBtn').hide();
                $('#searchResultsCount').hide();
            }
            if (_this.from > 0) {
                $('#searchPreviousBtn').removeClass('disabled');
            } else {
                $('#searchPreviousBtn').addClass('disabled');
            }

            if (_this.from + _this.pageSize >= _this.total) {
                $('#searchNextBtn').addClass('disabled');
            } else {
                $('#searchNextBtn').removeClass('disabled');
            }
            $("#searchResults").removeClass("loader");

            $('.search-video').magnificPopup({
              delegate: 'a', // child items selector, by clicking on it popup will open
              type: 'iframe'
              // other options
            });
        },function() {
            $("#searchResults").removeClass("loader");
            $('#searchResults').html("Uhoh, something's wrong... please <a href='https://github.com/MobileFirst-Platform-Developer-Center/DevCenter/issues/'>open an issue to let us know.");
        });
    },
    nextPage: function() {
        if (_this.from + _this.pageSize < _this.total) {
            this.from = this.from + this.pageSize;
            this.executeSearch();
        }
    },
    previousPage: function() {
        if (_this.from > 0) {
            this.from = this.from - +this.pageSize;
            this.executeSearch();
        }
    },
    updateFilters: function() {
        this.body.filter = {
            "bool": {
                "must": []
            }
        };
        this.from = 0;
        var mustArray = this.body.filter.bool.must;
        var selectedVersions = $('#versions option:selected');
        if (selectedVersions.length > 0) {
            var versionsArray = [];
            $.each(selectedVersions, function(index, result) {
                versionsArray.push(result.value);
            });
            mustArray.push({
                "terms": {
                    "version": versionsArray
                }
            });
        }
        var selectedType = $('#document-type option:selected');
        if (selectedType.length > 0) {
            var typesArray = [];
            $.each(selectedType, function(index, result) {
                typesArray.push(result.value);
            });
            mustArray.push({
                "terms": {
                    "type": typesArray
                }
            });
        }
        var selectedLanguage = $('#language option:selected');
        if (selectedLanguage.length > 0) {
            var languagesArray = [];
            $.each(selectedLanguage, function(index, result) {
                languagesArray.push(result.value);
            });
            mustArray.push({
                "terms": {
                    "language": languagesArray
                }
            });
        }
        var selectedPlatforms = $('#platforms option:selected');
        if (selectedPlatforms.length > 0) {
            var platformsArray = [];
            $.each(selectedPlatforms, function(index, result) {
                platformsArray.push(result.value);
                if (result.value == "cordova"){
                  platformsArray.push("hybrid");
                }
            });
            mustArray.push({
                "bool": {
                    "should": [{
                        "terms": {
                            "relevantTo": platformsArray
                        }
                    }, {
                        "terms": {
                            "tags": platformsArray
                        }
                    }]
                }
            });
        }
        this.executeSearch();
    },
    init: function() {
        this.client = new $.es.Client({
            protocol: 'https',
            // hosts: 'mfpsearch.mybluemix.net'
            hosts: 'portal-ssl403-12.bmix-dal-yp-4e981698-2fe4-416b-b80d-dcc839ed7ed8.bluempus-in-ibm-com.composedb.com',
            port: '29660'

            // hosts: 'bluemix-sandbox-dal-9-portal.0.dblayer.com:30448'
        });

        this.queryTerm = this.getParameterByName('q');
        this.queryAuthorName = this.getParameterByName('author');

        if (this.queryTerm !== null) {
            this.body = {
                "query": {
                    "multi_match": {
                        "query": this.queryTerm,
                        "operator": "and",
                        "fields": ["title", "content", "author.name", "tags"],
                        "fuzziness": "AUTO"
                    }
                },
                "highlight": {
                    "fields": {
                        "title": {},
                        "content": {}
                    }
                }
            };
            this.updateFilters();
        } else if (this.queryAuthorName !== null) {
            this.body = {
                "query": {
                    "multi_match": {
                        "query": this.queryAuthorName,
                        "operator": "and",
                        "fields": ["author.name"]
                    }
                }
            };
            this.updateFilters();
        }

        var _this = this;
        $('#searchNextBtn a').bind('click', function() {
            _this.nextPage();
        });
        $('#searchPreviousBtn a').bind('click', function() {
            _this.previousPage();
        });
    }
};

$(function() {
    $("#filters").show();
    MFPSEARCH.init();
    $('#document-type').multiselect({
        nonSelectedText: "Document type",
        onChange: function(option, checked, select) {
            MFPSEARCH.updateFilters();
        }
    });
    $('#platforms').multiselect({
        nonSelectedText: "Platforms",
        onChange: function(option, checked, select) {
            MFPSEARCH.updateFilters();
        }
    });
    $('#language').multiselect({
        nonSelectedText: "Language",
        onChange: function(option, checked, select) {
            MFPSEARCH.updateFilters();
        }
    });
    $('#versions').multiselect({
        nonSelectedText: "Versions",
        onChange: function(option, checked, select) {
            MFPSEARCH.updateFilters();
        }
    });
});
