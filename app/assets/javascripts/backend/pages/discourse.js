/*
 *  Document   : discourse.js
 *  Author     : Michael Winton
 *  Description: Custom scripts for the pitchcards show pages
 *
 *= require_self
 */

var Discourse = function() {

    function injectPopovers(){

        $('.scope-popover').on('click', function(e){
            e.preventDefault();
        }).popover({
            html: true
        });

        $("[data-toggle='popover']").on('shown.bs.popover', function(){

            $('.scope-submit').on('click',function(e) {

                e.preventDefault();
                e.stopPropagation();

                var form = $(this).closest("form");
                var popover = $(this).parents("div.popover-content")[0];
                var loading = $(popover).find(".scope-loading");

                var url = $(form).attr( "action" );
                var type = $(form).attr( "method" );
                var data = $(form).serialize();

                $.ajax({
                    url: url,
                    type: type,
                    data: data,
                    success: function(data) {
                        console.log(data);
                    },
                    beforeSend: function(){
                        $( loading ).removeClass("hidden");
                        $( form ).addClass("scope-hidden");
                    },
                    complete: function(){
                        $( loading ).addClass("hidden");
                        $( form ).removeClass("scope-hidden");
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