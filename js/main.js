$(function() {
    jQuery("abbr.timeago").timeago();

    $(".accordion").on("shown.bs.collapse", function(e) {
      var myEl = $(this).find('.collapse.in').prev('.panel-heading');

      $('html, body').animate({
        scrollTop: $(myEl).offset().top - 6
      }, 500);
      e.stopPropagation();
    });

    // Initialize the GIF player.
    $('body').imagesLoaded(function(){
      $('.gifplayer').gifplayer({wait: 'true'});
    });

    // Use AnchorJS to generate anchors.
    anchors.add();
    anchors.remove('.no-anchor');
});