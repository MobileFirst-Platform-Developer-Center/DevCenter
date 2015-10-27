var openedItems = $('.tutorial .col-sm-2 .navmenu-default li.open');
if(openedItems.length){
  openedItems[0].closable = false;
}

$('.tutorial .col-sm-2 .navmenu-default li ul').on('click',function(e){
  e.stopPropagation();
});

$('.tutorial .col-sm-2 .navmenu-default li').on({
    "shown.bs.dropdown": function() {
      this.closable = false;
    },
    "click":             function() {
      var openedItems = $('.tutorial .col-sm-2 .navmenu-default li.open');
      if(openedItems.length){
        openedItems[0].closable = true;
      }
    },
    "hide.bs.dropdown":  function() {
      return this.closable;
    }
});
