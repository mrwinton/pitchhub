/*
 *  Document   : suggestions.js
 *  Author     : Michael Winton
 *  Description: Custom scripts for the suggestions logic
 *
 *= require_self
 */

$(function() {

    $(".btn-suggest").click(function() {
        var textAreaId = "#" + $(this).attr('id')+"-textarea-input";
        var value = $(textAreaId).val().replace(/\s/g,"_");
        var hrefAttr = $(this).attr('href');
        var hrefArray = hrefAttr.split("?");
        var href = hrefArray[0] + "?content="+value;

        $(this).attr("href", href);

        var textAreaOriginalId = "#" + $(this).attr('id')+"-textarea-original";
        var originalValue = $(textAreaOriginalId).val();
        $(textAreaId).val(originalValue);

    });

});