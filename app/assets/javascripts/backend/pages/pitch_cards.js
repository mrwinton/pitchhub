/*
 *  Document   : pitch_cards.js
 *  Author     : Michael Winton
 *  Description: Custom scripts for the pitchcards pages
 *
 *= require_self
 */
var PitchCards = function() {

    /* Initialization UI Code */
    var uiInit = function() {

        $(".select-chosen").chosen({disable_search_threshold: 10, width: "100%"})

    };

    return {
        init: function() {
            uiInit(); // Initialize UI Code
        }
    };
}();

/* Initialize app when page loads */
$(function(){ PitchCards.init(); });