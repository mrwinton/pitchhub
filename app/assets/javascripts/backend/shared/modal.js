/*
 *  Document   : modal.js
 *  Author     : Michael Winton
 *  Description: Custom script that configures modal rendering
 *
 *= require_self
 */

$(function() {
    $('form[data-toggle=modal]').on('click', function() {
        return $('.dropdown').removeClass('open');
    });

    $('form[data-target=#ajax-modal]').on('click', function(e) {
        e.preventDefault();
        e.stopPropagation();
        $('body').modalmanager('loading');
        return $.rails.handleRemote($(this));
    });

    $(document).on('click', '[data-dismiss=modal], .modal-scrollable', function() {
        return $('.modal-body-content').empty();
    });

    $(document).on('click', '#ajax-modal', function(e) {
        return e.stopPropagation();
    });
});