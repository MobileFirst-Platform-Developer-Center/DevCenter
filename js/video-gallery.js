---
---
'use strict';
var videos = [];
var videoTags = [];

function displayVideos(tag){
    
  $('#videosList').html('');
  $('#videoTags span').removeClass('label-success').addClass('label-info');
  var videoTemplate = $.templates("#videoTemplate");
  var filteredVideos;
  if(tag){
    filteredVideos = jQuery.grep(videos,function(video){
      var index = jQuery.inArray(tag,video.tags);
      return index!=-1;
    });
    $('#videoTags *[data-tag="'+tag+'"]').removeClass('label-info').addClass('label-success');
  }
  else{
    filteredVideos = videos;
    $('#videoTags *[data-tag=""]').removeClass('label-info').addClass('label-success');
  }
  $.each(filteredVideos, function(index,video){
    $('#videosList').append(videoTemplate.render(video));
  });
}
function displayVideoTags(){
  $('#videoTags').html('');
  $.each(videos, function(index,video){
    videoTags = videoTags.concat(video.tags);
  });
  videoTags = videoTags.filter(function(item, pos, self) {
      return self.indexOf(item) == pos;
  });
  $('#videoTags').append('<span class="videoTag label label-info" data-tag="" role="button">All</span>');
  $.each(videoTags, function(index,tag){
    $('#videoTags').append('<span class="videoTag label label-info" data-tag="'+tag+'" role="button">'+tag+'</span>');
  });
  $('#videoTags span').on('click',function(event){
    displayVideos($(event.currentTarget).data('tag'));
  });
}
$(document).ready(function ($) {
  $('.gallery').magnificPopup({
    delegate: 'a', // child items selector, by clicking on it popup will open
    type: 'iframe'
    // other options
  });
  $.ajax('{{site.baseurl}}/js/data/videos.json',{
    success: function(data){
      videos = data;
      displayVideoTags();
      displayVideos();
    }
  });
});
