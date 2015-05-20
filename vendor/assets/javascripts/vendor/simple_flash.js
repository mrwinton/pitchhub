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

        new PNotify({
            text: message,
            type: type,
            icon: false
        });

    }

});