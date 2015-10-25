$("#accordion").on("shown.bs.collapse", function () {
    var myEl = $(this).find('.collapse.in').prev('.panel-heading');

    $('html, body').animate({
        scrollTop: $(myEl).offset().top - 6
    }, 500);
});
