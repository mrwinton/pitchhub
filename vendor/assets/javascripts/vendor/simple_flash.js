/**
 * Created by michaelwinton on 20/05/15.
 */

/**
 * Simple flash message
 */
$(function() {

    var flash = $("#flash");

    if (flash.length>0) {

        var message = flash.find("p").text(),
            type = "info";

        if (flash.hasClass("error")){
            type = "error"
        }

        var opts = {
            text: message,
            closer: false,
            sticker: false,
            type: type,
            icon: false,
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

});