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

    // feature rotator
    //function shuffle(array) {
    //    for (var i = array.length - 1; i > 0; i--) {
    //        var j = Math.floor(Math.random() * (i + 1));
    //        var temp = array[i];
    //        array[i] = array[j];
    //        array[j] = temp;
    //    }
    //    return array;
    //}

    // http://momentumdash.com
    //var $feature = $('.feature');
    //var features = ["inspiration", "todo", "weather", "quotes", "photography", "focus", "positivity", "motivation"];
    //shuffle(features);
    //$feature.html(features[features.length - 1]);
    //$feature.css('width', $feature.width());
    //
    //$.fn.rotateFeatures = function() {
    //    var feature = features.shift()
    //    features.push(feature);
    //
    //    var self = this;
    //    self.fadeTo(fadetime, 0, function() {
    //        self.append('<span class="prototype">' + feature + '</span>');
    //        var newWidth = self.find('.prototype').width();
    //        self.css('width', newWidth + 'px').html(feature).fadeTo(fadetime, 1);
    //    });
    //    return this;
    //};

});