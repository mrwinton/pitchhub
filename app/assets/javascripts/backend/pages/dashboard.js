/*
 *  Document   : dashboard.js
 *  Author     : Michael Winton
 *  Description: Custom javascript code used in the dashboard page
 *
 *= require_self
 */

$(function() {
    return $('#dashboard-content').infinitePages({
        debug: true,
        loading: function() {
            return $(this).text('Loading next page...');
        },
        error: function() {
            return $(this).button('There was an error, please try again');
        }
    });
});