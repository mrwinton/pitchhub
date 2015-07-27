/*
 *  Document   : grid.js
 *  Author     : Michael Winton
 *  Description: Custom script that sets up the grid view
 *
 *= require_self
 */

$(function() {

    function updatePitchPointTextArea(el, animate){
        setTimeout(function(){
            el.style.cssText = 'height:auto';

            if(animate){
                $(el).animate({
                    height:  el.scrollHeight + 'px'
                }, 500, function() {
                    // Animation complete.
                });
            } else {
                el.style.cssText = 'height:' + el.scrollHeight + 'px';
            }

        },0);
    }

    function refreshViewContent(){
        jQuery("abbr.timeago").timeago();

        var pitchPoint = $(".form-pitch-point");

        pitchPoint.each(function() {
            updatePitchPointTextArea(this, false);
        });

    }

    //Important that we resize before masonry does it's thing
    refreshViewContent();

    var $container = $('#masonry-container');
    $container.imagesLoaded(function(){
        $container.masonry({
            itemSelector : '.box',
            gutter: 20,
            isFitWidth: true,
            columnWidth : 380
        });

        // Reveal content
        $("#pitch-cards-loader").css({ display: "none" });
        $("#pitch-cards-content").removeClass("pitch-cards-hidden").addClass("animation-fadeInQuick");

    });


});