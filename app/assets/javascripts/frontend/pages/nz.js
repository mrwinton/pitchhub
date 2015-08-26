/*
 *  Document   : nz.js
 *  Author     : Michael
 *  Description: Cool light up New Zealand thingy
 *
 *= require_self
 */

$(function() {

    function pulse(pt){

        var attr = $(pt).attr('class');

        if (attr !== "pulse") {
            $(pt).attr("class", "pulse");
            console.log("set");

        } else {
            $(pt).attr("class", "");
            console.log("unset");
        }

    }

    var url = $("#nz-svg-url").val();

    d3.xml(url, "image/svg+xml", function(xml) {
        var importedNode = document.importNode(xml.documentElement, true);
        $('#nz-container').append(importedNode.cloneNode(true));

        var pts = $('rect');

        setInterval(
            function(){

                var length = pts.length;

                var number = Math.floor(Math.random() * length);

                console.log("hey: "+number);

                var pt = pts[number];

                pulse(pt);

            }, 1233);

        setInterval(
            function(){

                var length = pts.length;

                var number = Math.floor(Math.random() * length);

                console.log("hey: "+number);

                var pt = pts[number];

                pulse(pt);

            }, 2200);

        setInterval(
            function(){

                var length = pts.length;

                var number = Math.floor(Math.random() * length);

                console.log("hey: "+number);

                var pt = pts[number];

                pulse(pt);

            }, 3090);
    });

});