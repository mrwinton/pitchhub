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

    var pitchPointSelectionLogicInit = function(){

        $(".pitch-point-selector").click(function() {

            var pitchPointId = $(this).attr('id').split("-selector")[0];

            var pitchPoint = $("#"+pitchPointId);

            var isSelectedElem = pitchPoint.find("#"+pitchPointId+"-selected");

            var isSelectedValue = isSelectedElem.val();

            var isSelected = isSelectedValue == "selected";

            var textArea = pitchPoint.find("textarea");

            if(isSelected === true){
                //changing to deselected

                textArea.prop('disabled',true);
            } else {
                //changing to selected

                textArea.prop('disabled',false);
            }

            var images = pitchPoint.find("img");

            for (var i = 0; i < images.length; i++){
                var image = $(images[i]);

                if(image.hasClass("hidden")){
                    image.removeClass("hidden");
                } else {
                    image.addClass("hidden");
                }
            }

            var newState = isSelected ? "deselected" : "selected";

            isSelectedElem.val( newState );

        });

    };

    return {
        init: function() {
            uiInit(); // Initialize UI Code
            pitchPointSelectionLogicInit();
        }
    };
}();

/* Initialize app when page loads */
$(function(){ PitchCards.init(); });