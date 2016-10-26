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
    
    // Navigate to tabs with hash tags.
    var urlFragment = document.location.toString();
    if (urlFragment.match('#')) {
        $('.nav-tabs a[href="#' + urlFragment.split('#')[1] + '"]').tab('show');
    } 
    $('.nav-tabs a').on('shown.bs.tab', function (e) {
        window.location.hash = e.target.hash;
    });
    
    // Scroll to top
    $(document).ready(function(){
        $(window).scroll(function(){
            if ($(this).scrollTop() > 100) {
                $('.scrollUpButton').fadeIn();
            } else {
                $('.scrollUpButton').fadeOut();
            }
        });
        $('.scrollUpButton').click(function(){
            $("html, body").animate({ scrollTop: 0 }, 500);
            return false;
        });
    });
    
    $(".navbar .navmenu-nav a").click(function(){ $('selector').offcanvas('hide'); });
});