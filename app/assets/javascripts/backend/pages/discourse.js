/*
 *  Document   : discourse.js
 *  Author     : Michael Winton
 *  Description: Custom scripts for the pitchcards show pages
 *
 *= require_self
 */

var Discourse = function() {

    var discourseArray = [];

    function discourseLoadingComplete(){

        var allEmpty = true;
        var complete = true;
        var index;
        for	(index = 0; index < discourseArray.length; index++) {
            if(false == discourseArray[index].complete){
                complete = false;
                break;
            } else if(false == discourseArray[index].empty){
                allEmpty = false;
            }
        }

        if(true == complete){
            //  show discourses
            $("#discourses-loader").addClass("hidden");

            if(allEmpty){
                $("#discourses-empty").addClass("animation-fadeInQuick");
            }

            console.log("Done!");
        } else {
            setTimeout(discourseLoadingComplete, 1000);
        }

    }

    /* Initialization UI Code */
    var uiInit = function() {

        //$('.placard').placard();

    };

    var discourseInit = function(){

        $( ".discourse" ).each(function() {

            var discourse = this.id;
            var id = $(this).val();

            discourseArray[discourse] = { complete: false, error: false, status: 'init', empty: true };

            var request = void 0;
            request = $.ajax({
                url: "/discourses/"+id
            });
            request.done(function(data, textStatus, jqXHR) {
                if(data.length > 0){

                    discourseArray[discourse].empty = false;
                } else { // no data
                    discourseArray[discourse].empty = true;
                }
                // render into DOM
                discourseArray[discourse].status = textStatus;
                discourseArray[discourse].complete = true;
            });
            request.error(function(jqXHR, textStatus, errorThrown) {
                discourseArray[discourse].complete = true;
                discourseArray[discourse].error = true;
                discourseArray[discourse].status = textStatus;
            });
        });

        setTimeout(discourseLoadingComplete, 1000);
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