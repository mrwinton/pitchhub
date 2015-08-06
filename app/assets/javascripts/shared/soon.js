/*
 *  Document   : soon.js
 *  Author     : Michael Winton
 *  Description: Cool word switcher
 *
 *= require_self
 */
$(function() {

    function notifyComingSoon(entity){

        var message = entity + " coming soon!";

        var opts = {
            text: message,
            closer: true,
            sticker: false,
            icon: 'fa fa-heart-o',
            nonblock: {
                nonblock: true,
                nonblock_opacity: .2
            }
        };

        var context = $("#page-content");

        if (context.length>0) {
            opts.addclass = "push-stack";
        } else {
            opts.addclass = "push-stack-more";
        }

        new PNotify(opts);

    }

    $(".page-coming-soon").click(function( event ) {

        event.preventDefault();

        notifyComingSoon("Page");

    });

    $(".feature-coming-soon").click(function( event ) {

        event.preventDefault();

        notifyComingSoon("Feature");

    });

});