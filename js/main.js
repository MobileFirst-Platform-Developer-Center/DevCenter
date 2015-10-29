$(function() {
    $('#form_site_search').on('submit', function(e) {
        var search_input = $('#pnext-search-input');
        var search_actual = $('#pnext-search-input-hidden');
        search_actual.val(search_input.val()+' more:nextmobile');
        //$('#form_site_search').submit();
        return true;
    });
});
