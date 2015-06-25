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

        //$('.placard').placard();

    };


    return {
        init: function() {
            uiInit(); // Initialize UI Code
        }
    };
}();

/* Initialize app when page loads */
$(function(){ Discourse.init(); });