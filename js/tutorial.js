"use strict";
$(function() {
    var openedItems = $('.tutorial .sidebar .navmenu-default li.open');
    if (openedItems.length) {
        for (var i = 0; i < openedItems.length; i++) {
            openedItems[i].closable = false;
        }
    }

    $('.tutorial .sidebar .navmenu-default li ul').on('click', function(e) {
        e.stopPropagation();
    });

    $('.tutorial .sidebar .navmenu-default li').on({
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

    $('.tutorial table').not('.highlight table').addClass("table table-striped");

});