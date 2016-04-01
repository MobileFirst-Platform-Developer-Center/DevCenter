$(function() {
    $('#form_site_search').on('submit', function(e) {
        var search_input = $('#pnext-search-input');
        var search_actual = $('#pnext-search-input-hidden');
        search_actual.val(search_input.val());
        return true;
    });

    jQuery("abbr.timeago").timeago();

    $(".accordion").on("shown.bs.collapse", function() {
      var myEl = $(this).find('.collapse.in').prev('.panel-heading');

      $('html, body').animate({
        scrollTop: $(myEl).offset().top - 6
      }, 500);
    });

    $('body').imagesLoaded(function(){
      $('.gifplayer').gifplayer({wait: 'true'});
    });
});
