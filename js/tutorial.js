$(function() {
  var openedItems = $('.tutorial .col-sm-2 .navmenu-default li.open');
  if (openedItems.length) {
    for (var i = 0; i < openedItems.length; i++) {
      openedItems[i].closable = false;
    }
  }

  $('.tutorial .col-sm-2 .navmenu-default li ul').on('click', function(e) {
    e.stopPropagation();
  });

  $('.tutorial .col-sm-2 .navmenu-default li').on({
    "shown.bs.dropdown": function() {
      this.closable = false;
    },
    "click": function(event) {
      event.currentTarget.closable = true;
    },
    "hide.bs.dropdown": function() {
      return this.closable;
    }
  });

  $("#accordion").on("shown.bs.collapse", function() {
    var myEl = $(this).find('.collapse.in').prev('.panel-heading');

    $('html, body').animate({
      scrollTop: $(myEl).offset().top - 6
    }, 500);
  });

  $('.tutorial table').addClass("table table-striped");

});
