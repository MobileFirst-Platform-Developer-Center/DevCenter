$(document).ready(function ($) {
  $('.gallery').magnificPopup({
    delegate: 'a', // child items selector, by clicking on it popup will open
    type: 'iframe'
    // other options
  });
  $.ajax('/js/data/videos.json',{
    success: function(data){
      console.log(data);
      var videoTemplate = $.templates("#videoTemplate");
      $.each(data, function(index,video){
        $('#videosList').append(videoTemplate.render(video));
      });
    }
  });
});
