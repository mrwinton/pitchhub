/*
 *  Document   : modal.js
 *  Author     : Michael Winton
 *  Description: Custom script that configures modal rendering
 *
 *= require_self
 */


function registerModalListeners(){
    $('form[data-toggle=modal]').on('click', function() {
        return $('.dropdown').removeClass('open');
    });

    //Default click behaviour is to post to a new page
    //We prevent this and then submit the form in AJAX
    $(".modal-submit").on('click', function(e) {
        e.preventDefault();
        e.stopPropagation();
        var form = $(this).closest("form");

        var contentElem = $(form).find("#content");
        var content = $(contentElem).val();
        var originalContent = $(form).find("#original-content").val();

        var lengthValid = content.length > 0;
        var contentValid = content !== originalContent;

        if(lengthValid){

            if(contentValid){
                $('body').modalmanager('loading');
                return $.rails.handleRemote($(form));
            } else {

                new PNotify({
                    text: 'Oops, please change the input!',
                    type: 'error'
                });

            }

        } else {

            $(contentElem).val(originalContent);

            new PNotify({
                text: 'Sorry, the input cannot be empty!',
                type: 'error'
            });

        }
    });

    //Stop form from submitting on regular clicks
    $('form[data-target=#ajax-modal]').on('click', function(e) {
        e.preventDefault();
        e.stopPropagation();
    });

    //Close placard on cancel
    $("a.placard-cancel").on('click', function(e) {
        e.preventDefault();
        e.stopPropagation();
    });

    //When clicked away from placard, reset the content
    $(document).on('click', '[data-dismiss=modal], .modal-scrollable', function() {
        return $('.modal-body-content').empty();
    });

    //IN THE MODAL FORM

    //Submit
    $(document).on('click', '#ajax-modal', function(e) {
        return e.stopPropagation();
    });
}

$(function() {
    registerModalListeners();
});