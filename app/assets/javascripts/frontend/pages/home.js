/*
 *  Document   : home.js
 *  Author     : Xamarin
 *  Description: Cool word switcher
 *
 *= require_self
 */
$(function() {

    // Hero word switcher

    console.log("test");

    var switcher = $('#hero-word-switcher');
    var delay = 3141;
    var count = switcher.find('span').length;

    function calculateWidths() {
        switcher.find('span').each(function(index) {
            $(this).attr('data-width', $(this).width());
        });
        switcher.width(switcher.find('.active').attr('data-width'));
    }
    calculateWidths();

    $(window).resize(function() {
        calculateWidths();
    });

    function doChange() {
        var nextItem;
        var currentItem = parseInt(switcher.find('.active').attr('data-oid'));

        if (currentItem == count - 1) {
            nextItem = 0;
        } else {
            nextItem = currentItem + 1;
        }

        switcher.addClass('in');

        //removes active, adds inactive
        switcher.find('[data-oid="' + currentItem + '"]').removeClass('active').addClass('inactive');
        switcher.find('[data-oid="' + nextItem + '"]').addClass('active').removeClass('inactive');

        switcher.width(switcher.find('[data-oid="' + nextItem + '"]').attr('data-width'));
        setTimeout(doChange, delay);
    }

    setTimeout(doChange, delay);


});