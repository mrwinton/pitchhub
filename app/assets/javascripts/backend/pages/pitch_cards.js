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

    var maxLengthLogicInit = function() {

        $('textarea[maxlength]').maxlength({
            threshold: 20,
            warningClass: "label label-success",
            limitReachedClass: "label label-danger"
        });

    };

    var pitchPointSelectionLogicInit = function(){

        $(".pitch-point-selector").click(function() {

            var pitchPointId = $(this).attr('id').split("-selector")[0],
                pitchPoint = $("#"+pitchPointId),
                //get the pitch point's hidden selector
                isSelectedElem = pitchPoint.find("#"+pitchPointId+"-selected"),
                //get the value
                isSelectedValue = isSelectedElem.val(),
                //check if it's selected
                isSelected = isSelectedValue == "true",
                //get the elements to update with the new state
                textArea = pitchPoint.find("textarea"),
                imageSelected = pitchPoint.find("img.pitch-point-selected"),
                imageDeselected = pitchPoint.find("img.pitch-point-deselected");

            //update the elements with the new state
            if(isSelected === true){
                //changing to deselected
                textArea.val("");
                textArea.prop('disabled',true);
                isSelectedElem.val( false );
                imageSelected.addClass("hidden");
                imageDeselected.removeClass("hidden");
            } else {
                //changing to selected
                textArea.prop('disabled',false);
                isSelectedElem.val( true );
                imageSelected.removeClass("hidden");
                imageDeselected.addClass("hidden");
            }

        });

    };

    return {
        init: function() {
            uiInit(); // Initialize UI Code
            maxLengthLogicInit();
            pitchPointSelectionLogicInit();
        }
    };
}();

/* Initialize app when page loads */
$(function(){ PitchCards.init(); });