var videos = [];
function displayVideos(){
  var videoTemplate = $.templates("#videoTemplate");
  $.each(videos, function(index,video){
    $('#videosList').append(videoTemplate.render(video));
  });
}
$(document).ready(function ($) {
  $('.gallery').magnificPopup({
    delegate: 'a', // child items selector, by clicking on it popup will open
    type: 'iframe'
    // other options
  });
  $.ajax('/js/data/videos.json',{
    success: function(data){  
      videos = data;
      displayVideos();
    }
  });
});
