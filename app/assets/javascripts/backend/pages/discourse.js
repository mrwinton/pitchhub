/*
 *  Document   : discourse.js
 *  Author     : Michael Winton
 *  Description: Custom scripts for the pitchcards show pages
 *
 *= require_self
 */

var Discourse = function() {

    /* Initialization UI Code */
    var uiInit = function() {

    };

    var discourseInit = function(){

        var pitch_card_id = $("#pitch-card-id").val(),
            url = pitch_card_id + "/comments";

        $.ajax({
            url: url, type: "GET",
            success: hider
        });
        function hider() {
            var content = "#discourses-content";
            $("#discourses-loader").addClass("hidden");
            //Hide or Show divs based on whether we have content.
            if ($.trim($(content).html())=='') {
                var empty = "#discourses-empty";
                $(empty).removeClass("hidden");
                $(empty).addClass("animation-fadeInQuick");
            }
            if ($.trim($(content).html())!='') {
                $(content).removeClass("hidden");
                jQuery("abbr.timeago").timeago();
                $(content).addClass("animation-fadeInQuick");
            }
        }

    };


    return {
        init: function() {
            uiInit(); // Initialize UI Code
            discourseInit(); //Initialise the discourse loading code
        }
    };
}();

/* Initialize app when page loads */
$(function(){ Discourse.init(); });