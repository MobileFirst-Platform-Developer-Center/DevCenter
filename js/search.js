// SPIN.JS
var opts = {
    lines: 13,
    length: 28,
    width: 14,
    radius: 42,
    scale: 1,
    corners: 1,
    color: '#000',
    opacity: 0.20,
    rotate: 0,
    direction: 1,
    speed: 1.0,
    trail: 70,
    fps: 20,
    zIndex: 2e9,
    className: 'spin',
    top: '35%',
    left: '50%',
    shadow: false,
    hwaccel: false,
    position: 'absolute'
};

var spinner = new Spinner(opts);

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
        spinner.spin(document.getElementById('searchResults'));

        var _this = this;
        this.client.search(this.body).then(function(body) {
            console.log(body);
            _this.total = body.hits.total;
            $('#queryTerm').html(_this.total + " results");
            $('#search-input').val(_this.queryTerm);
            var searchResultTemplate = $.templates("#searchResultTemplate");
            $('#searchResults').html('');
            $('html,body').scrollTop(0);

            if (_this.total > 0 ) {
                $.each(body.hits.hits, function(index, result) {
                    result._source.highlight = result.highlight;
                    $('#searchResults').append(searchResultTemplate.render(result._source));
                });
                $('#searchNextBtn').show();
                $('#searchPreviousBtn').show();
            } else {
                $('#searchResults').html('No results were found. Try refining your search.');
                $('#searchNextBtn').hide();
                $('#searchPreviousBtn').hide();
            }
            if (_this.from > 0) {
                $('#searchPreviousBtn').removeClass('disabled');
            } else {
                $('#searchPreviousBtn').addClass('disabled');
            }

            if (_this.from + _this.pageSize > _this.total) {
                $('#searchNextBtn').addClass('disabled');
            } else {
                $('#searchNextBtn').removeClass('disabled');
            }
            spinner.stop();
        });
    },
    nextPage: function() {
        this.from = this.from + this.pageSize;
        this.body.from = this.from;
        this.executeSearch();
    },
    previousPage: function() {
        this.from = this.from - +this.pageSize;
        this.body.from = this.from;
        this.executeSearch();
    },
    init: function() {
        this.client = new $.es.Client({
            protocol: 'https',
            hosts: 'mfpsearch.mybluemix.net'
        });
        this.queryTerm = this.getParameterByName('q');
        if (this.queryTerm !== null) {
            this.body = {
                body: {
                  "query": {
                    "multi_match": {
                      "query": this.queryTerm,
                      "operator": "and",
                      "fields": ["title", "content", "author.name"]
                    }
                  },
                  "highlight": {
                    "fields": {
                      "title": {},
                      "content": {}
                    }
                  }
                }
            };
            this.executeSearch();
            _this = this;
            $('#searchNextBtn a').bind('click', function() {
                _this.nextPage();
            });
            $('#searchPreviousBtn a').bind('click', function() {
                _this.previousPage();
            });
        }
    }
};

$(function() {
    $("#filters").show();
    MFPSEARCH.init();
    $('#document-type').multiselect({
        nonSelectedText: "Document type"
    });
    $('#platforms').multiselect({
        nonSelectedText: "Platforms"
    });
    $('#versions').multiselect({
        nonSelectedText: "Versions"
    });
});
