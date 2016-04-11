var MFPSEARCH = {
  client: null,
  queryTerm: null,
  params: {},
  pageSize: 10,
  total: 0,
  from: 0,
  getParameterByName: function (name, url) {
      if (!url) url = window.location.href;
      name = name.replace(/[\[\]]/g, "\\$&");
      var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)", "i"),
          results = regex.exec(url);
      if (!results) return null;
      if (!results[2]) return '';
      return decodeURIComponent(results[2].replace(/\+/g, " "));
  },
  executeSearch: function(){
    var _this = this;
    this.client.search(this.params).then(function(body){
      console.log(body);
      _this.total = body.hits.total;
      $('#queryTerm').html(_this.queryTerm + " - " + _this.total + " results");
      var searchResultTemplate = $.templates("#searchResultTemplate");
      $('#searchResults').html('');
      $('html,body').scrollTop(0);
      $.each(body.hits.hits, function(index,result){
        $('#searchResults').append(searchResultTemplate.render(result._source));
      });
      if(_this.from > 0){
        $('#searchPreviousBtn').removeClass('disabled');
      }
      else{
        $('#searchPreviousBtn').addClass('disabled');
      }

      if(_this.from + _this.pageSize > _this.total){
        $('#searchNextBtn').addClass('disabled');
      }
      else{
        $('#searchNextBtn').removeClass('disabled');
      }
    });
  },
  nextPage: function(){
    this.from = this.from + this.pageSize;
    this.params.from = this.from;
    this.executeSearch();
  },
  previousPage: function(){
    this.from = this.from - + this.pageSize;
    this.params.from = this.from;
    this.executeSearch();
  },
  init: function(){
    this.client = new $.es.Client({
      hosts: 'mfpsearch.mybluemix.net'
    });
    this.queryTerm = this.getParameterByName('q');
    if(this.queryTerm !== null){
      this.params = {q: this.queryTerm};
      this.executeSearch();
      _this = this;
      $('#searchNextBtn a').bind('click',function(){_this.nextPage();});
      $('#searchPreviousBtn a').bind('click',function(){_this.previousPage();});
    }
  }
};

$(function() {
  MFPSEARCH.init();
});
