var openedItem = $('.tutorial .col-sm-2 .navmenu-default li.open')[0];
openedItem.closable = false;

$('.tutorial .col-sm-2 .navmenu-default li').on({
    "shown.bs.dropdown": function() {
      this.closable = false;
    },
    "click":             function() {
      this.closable = true;
    },
    "hide.bs.dropdown":  function() {
      return this.closable;
    }
});
