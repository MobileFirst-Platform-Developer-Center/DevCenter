function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)", "i"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}
$(function() {
  var client = new $.es.Client({
    hosts: 'localhost:9200'
  });
  var queryTerm = getParameterByName('q');
  if(queryTerm !== null){
    $('#queryTerm').html(queryTerm);
    client.search({q: queryTerm}).then(function(body){
      console.log(body);
      var searchResultTemplate = $.templates("#searchResultTemplate");
      $.each(body.hits.hits, function(index,result){
        $('#searchResults').append(searchResultTemplate.render(result._source));
      });
    });
  }
});
