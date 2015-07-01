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

    function renderSuggestion(suggestion){
        //construct element body

        var sTextArea = "<textarea class=\"form-horizontal form-control-borderless form-pitch-point\" maxlength=\"101\" readonly=\"readonly\" disabled=\"yes\">"  + suggestion.content + "</textarea>";
        var sComment = "<p>" + suggestion.comment + "</p>";
        var sAuthor = "<p>" + suggestion.author + "</p>";
        var suggestionHTML = sTextArea + sComment + sAuthor;

        return suggestionHTML;

    }

    function renderComment(comment){
        return "comment";
    }

    function renderPushedComments(comments){
        return "pushed comment";
    }

    function renderDiscourseThread(target, root, descendants){
        var discourseThread = "<li class=\"media\"><div class=\"media-body\">" + root + descendants + "</div></li>"
        $( target ).append( discourseThread );
    }

    function renderDiscourse(target, data){
        console.log(data);

        var roots = {};
        var descendants = {};

        var i;
        for (i = 0; i < data.length; i++) {
            var message = data[i];

            if(message.message_type === "root"){ //root
                roots[message._id] = message;
            } else { //descendant

                if(_.has(descendants, message._parent_id)){ //add to existing array
                    //push on to array
                    descendants[message._parent_id].push(message);

                } else {
                    //parent id not already in descendants

                    //create new array
                    var descendantsArray = [];
                    //add this message to array
                    descendantsArray.push(message);
                    //on message's parent id add the array
                    descendants[message._parent_id] = descendantsArray;
                }
            }
        }

        // for each root, render the itself and then it's descendants (if any)
        $.each(roots, function( index, root ) {
            if(root.type === "suggestion"){
                var suggestionHTML = renderSuggestion(root);
                var pushedCommentsHTML = "";

                if(_.has(descendants, root._id)){
                    pushedCommentsHTML = renderPushedComments(descendants[root._id])
                }

                renderDiscourseThread(target, suggestionHTML, pushedCommentsHTML);

            } else if(root.type === "comment"){

                var commentHTML = renderComment(root);
                var pushedCommentsHTML = "";

                if(_.has(descendants, root._id)){
                    pushedCommentsHTML = renderPushedComments(descendants[root._id])
                }

                renderDiscourseThread(target, commentHTML, pushedCommentsHTML);

            } else {
                console.log("error, unidentified root: " + root);
            }
        });
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