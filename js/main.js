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
    
    // Show/Hide recent updates/announcements sections
    $("#blogPostsHeadingAnnouncements").on("click", function() {
        $("#allPosts").hide();
        $("#announcements").show();
        $("#blogPostsHeadingUpdates").addClass("blogPostsHeadingInactive");
        $("#blogPostsHeadingAnnouncements").removeClass("blogPostsHeadingInactive");
        $("#blogPostsHeadingUpdates").style.marginRight = "0";
    });
    
    $("#blogPostsHeadingUpdates").on("click", function() {
        $("#announcements").hide();
        $("#allPosts").show();
        $("#blogPostsHeadingUpdates").removeClass("blogPostsHeadingInactive");
        $("#blogPostsHeadingAnnouncements").addClass("blogPostsHeadingInactive");
        $("#blogPostsHeadingUpdates").style.marginRight = "10px";
    });
});