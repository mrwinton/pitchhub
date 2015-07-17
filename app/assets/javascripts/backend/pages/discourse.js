/*
 *  Document   : discourse.js
 *  Author     : Michael Winton
 *  Description: Custom scripts for the pitchcards show pages
 *
 *= require_self
 */

var Discourse = function() {

    var lastFocusedPointScope = "";

    function injectPopovers(){

        $('.scope-popover').on('click', function(e){
            e.preventDefault();
        }).popover({
            html: true
        });

        $("[data-toggle='popover']").on('shown.bs.popover', function(){

            Discourse.lastFocusedPointScope = $(this).attr("id");

            $('.scope-submit').on('click',function(e) {

                e.preventDefault();
                e.stopPropagation();

                var form = $(this).closest("form");
                var popover = $(this).parents("div.popover-content")[0];
                var loading = $(popover).find(".scope-loading");
                var success_loading = $(loading).find(".scope-success");
                var spin_loading = $(loading).find(".scope-spin");

                var url = $(form).attr( "action" );
                var type = $(form).attr( "method" );
                var data = $(form).serialize();

                $.ajax({
                    url: url,
                    type: type,
                    data: data,
                    success: function(data) {

                        //update the link so the current selection shows on the form when clicked on again
                        var popoverLinkElement = $('#'+Discourse.lastFocusedPointScope);
                        var scope = data.content;

                        var selected = "selected=\"selected\"";
                        var value = "value=\"" + scope + "\"";
                        var selected_value = value + " " + selected;
                        var content = $(popoverLinkElement).attr("data-content");

                        content = content.replace(selected, "");
                        content = content.replace(value, selected_value);

                        $(popoverLinkElement).attr( "data-content", content );

                        setTimeout(function(){
                            $(spin_loading).addClass("hidden");
                            $(success_loading).removeClass("hidden");
                        }, 1000);

                        setTimeout(function(){
                            $(spin_loading).removeClass("hidden");
                            $(success_loading).addClass("hidden");
                        }, 4000);
                    },
                    beforeSend: function(){
                        $( loading ).removeClass("hidden");
                        $( form ).addClass("scope-hidden");
                    },
                    complete: function(){
                        setTimeout(function(){
                            $( loading ).addClass("hidden");
                            $( form ).removeClass("scope-hidden");
                        }, 4000);
                    }
                });

            });

        });

        $('body').on('click', function (e) {
            $('[data-toggle="popover"]').each(function () {
                //the 'is' for buttons that trigger popups
                //the 'has' for icons within a button that triggers a popup
                if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
                    $(this).popover('hide');
                }
            });
        });

    }

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
                injectPopovers();
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