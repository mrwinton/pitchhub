/*
 *  Document   : discourse.js
 *  Author     : Michael Winton
 *  Description: Custom scripts for the pitchcards show pages
 *
 *= require_self
 */

var Discourse = function() {

    var discourses = {};

    function discourseLoadingComplete(){

        var allEmpty = true;
        var complete = true;

        $.each(discourses, function( index, discourse ) {
            if(false == discourse.complete){
                complete = false;
            } else if(false == discourse.empty){
                allEmpty = false;
                $(discourse.content).removeClass("hidden");
            }
        });

        if(true == complete){
            //  show discourses
            $("#discourses-loader").addClass("hidden");

            if(true == allEmpty){
                var empty = "#discourses-empty";
                $(empty).removeClass("hidden");
                $(empty).addClass("animation-fadeInQuick");
            } else {
                $("#discourses-content").removeClass("hidden");
            }

            console.log("Done!");
        } else {
            console.log("Calling again!");
            setTimeout(discourseLoadingComplete, 1000);
        }

    }

    function renderDiscourse(target, data){
        console.log(data);

        var roots = {};
        //make descendants an id -> [message]
        var descendants = {};

        var i;
        for (i = 0; i < data.length; i++) {
            var message = data[i];

            if(message.message_type === "root"){
                roots[message._id] = message;
            } else {
                //id message
                descendants[message._id] = message;
            }
        }

        for (i = 0; i < roots.length; i++) {

            if(message.message_type === "root"){
                roots[message._id] = message;
            } else {
                descendants[message._id] = message;
            }
        }

        //construct element body
        $( target ).append( "<p>Test</p>" );
    }

    /* Initialization UI Code */
    var uiInit = function() {

        //$('.placard').placard();

    };

    var discourseInit = function(){

        $( ".discourse" ).each(function() {

            var discourse = this.id;
            var id = $(this).val();
            var content = "#" + discourse.replace("id", "content");
            var body = "#" + discourse.replace("id", "body");

            discourses[discourse] = { complete: false, error: false, status: 'init', content: content, body: body, empty: true };

            var request = void 0;
            request = $.ajax({
                url: "/discourses/"+id
            });
            request.done(function(data, textStatus, jqXHR) {
                if(data.length > 0){
                    renderDiscourse(discourses[discourse].body, data);
                    console.log("complete with data");
                    discourses[discourse].empty = false;
                } else { // no data
                    console.log("complete without data");
                    discourses[discourse].empty = true;
                }
                // render into DOM
                discourses[discourse].status = textStatus;
                discourses[discourse].complete = true;
            });
            request.error(function(jqXHR, textStatus, errorThrown) {
                console.log("finished with error");
                discourses[discourse].complete = true;
                discourses[discourse].error = true;
                discourses[discourse].status = textStatus;
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