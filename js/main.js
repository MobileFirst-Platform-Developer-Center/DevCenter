---
---
"use strict";

$(function() {
   // Use timeago library
   jQuery("abbr.timeago").timeago();

   // Appropriatly close accorditions
   $(".accordion").on("shown.bs.collapse", function(e) {
      var myEl = $(this).find('.collapse.in').prev('.panel-heading');

      $('html, body').animate({
        scrollTop: $(myEl).offset().top - 6
      }, 500);
      e.stopPropagation();
   });

   // Initialize the GIF player
   $('body').imagesLoaded(function(){
      $('.gifplayer').gifplayer({wait: 'true'});
   });

   // Use AnchorJS to generate anchors
   anchors.add();
   anchors.remove('.no-anchor');
    
   // Navigate to tabs with hash tags
   var urlFragment = document.location.toString();
   if (urlFragment.match('#')) {
      $('.nav-tabs a[href="#' + urlFragment.split('#')[1] + '"]').tab('show');
   } 
   
   $('.nav-tabs a').on('shown.bs.tab', function (e) {
      window.location.hash = e.target.hash;
   });
    
   // Scroll to top
   $(document).ready(function() {
      $(window).scroll(function() {
         if ($(this).scrollTop() > 100) {
            $('.scrollUpButton').fadeIn();
         } else {
            $('.scrollUpButton').fadeOut();
         }
      });
   });
      
   // Add scroll-to-top to tutorial pages
   $('.scrollUpButton').click(function(){
      $("html, body").animate({ scrollTop: 0 }, 500);
         return false;
   });
    
   // Update features indicator image on hover
   $("#comprehensive_security").on("mouseover", function() {
      $("#feature-indicator").attr("src","{{site.baseurl}}/assets/front-page/Line_1_Selected.svg");
      
      $("#comprehensive_security").on("mouseout", function() {
         $("#feature-indicator").attr("src","{{site.baseurl}}/assets/front-page/Line_None_Selected.svg");
      });
   });
   
   $("#mobile_analytics").on("mouseover", function() {
      $("#feature-indicator").attr("src","{{site.baseurl}}/assets/front-page/Line_2_Selected.svg");
      
      $("#mobile_analytics").on("mouseout", function() {
         $("#feature-indicator").attr("src","{{site.baseurl}}/assets/front-page/Line_None_Selected.svg");
      });
   });
   
   $("#app_lifecycle").on("mouseover", function() {
      $("#feature-indicator").attr("src","{{site.baseurl}}/assets/front-page/Line_3_Selected.svg");
      
      $("#app_lifecycle").on("mouseout", function() {
         $("#feature-indicator").attr("src","{{site.baseurl}}/assets/front-page/Line_None_Selected.svg");
      });
   });
   
   $("#backend").on("mouseover", function() {
      $("#feature-indicator").attr("src","{{site.baseurl}}/assets/front-page/Line_4_Selected.svg");
      
      $("#backend").on("mouseout", function() {
         $("#feature-indicator").attr("src","{{site.baseurl}}/assets/front-page/Line_None_Selected.svg");
      });
   });
   
   $("#push_sync").on("mouseover", function() {
      $("#feature-indicator").attr("src","{{site.baseurl}}/assets/front-page/Line_5_Selected.svg");
      
      $("#push_sync").on("mouseout", function() {
         $("#feature-indicator").attr("src","{{site.baseurl}}/assets/front-page/Line_None_Selected.svg");
      });
   });
});