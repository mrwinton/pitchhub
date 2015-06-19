/*
 *  Document   : upload.js
 *  Author     : Michael Winton
 *  Description: Custom script that configures dropzone uploads
 *
 *= require_self
 */

$(function() {

    Dropzone.autoDiscover = false;

    $("#new_pitch_card").dropzone({

        previewsContainer: ".dropzone-previews",

        clickable: false,

        uploadMultiple: false,

        maxFiles: 1,

        autoProcessQueue: false,

        //only allow image to be 1 mb max
        maxFilesize: 1,

        //make param name match field name in Pitch Card model
        paramName: "pitch_card[pitch_card_image]",

        //show remove links
        addRemoveLinks: true,

        success: function(file, response){
            //$(file.previewTemplate).find('.dz-remove').attr('id', response.fileID);
            //
            //$(file.previewTemplate).addClass("dz-success");
        },

        removedFile: function(file){

            //var id = $(file.previewTemplate).find('.dz-remove').attr('id');

        }


    });

});