/*
 *  Document   : upload.js
 *  Author     : Michael Winton
 *  Description: Custom script that configures dropzone uploads
 *
 *= require_self
 */

var app = {}

$(function() {

    $('.photo-preview').click(function (){
        imageClick();
    });

    $('.delete-photo').click(function (e){
        e.preventDefault();
        deletePhoto();
    });

    $('#uploadPitchCardImage').change(function(){
        $('.photo-preview').removeAttr('disabled');
        readUrl(this);
    });

    function imageClick(){
        $(this).attr('disabled', 'true');
        $('#uploadPitchCardImage').trigger('click');
    }

    function readUrl(input){
        if (input.files && input.files[0]){
            var reader = new FileReader();

            reader.onload = function (e) {
                app.cardImage = e.target.result;
                $('#upload-click').hide();
                $('.photo-preview').css('background', 'url(' + app.cardImage + ')');
                $('#remove-image').val( false );
            };

            $('.delete-photo').show();

            reader.readAsDataURL(input.files[0]);
        }
    }

    function deletePhoto(){

        //Update hidden field, to signal image delete
        $('#remove-image').val( true );

        //Update UI
        $('.delete-photo').hide();
        $('#uploadPitchCardImage').val('');
        $('.photo-preview').css('background', '');
        $('#upload-click').show();
    }

    function readUploadedPhoto(){

        var uploadedImage = $('#uploaded_image');

        if(uploadedImage.length>0){

            //var uploaded = url (uploadedImage.val() );

            $('#upload-click').hide();
            $('#uploadPitchCardImage').val('');
            $('.delete-photo').show();
            $('.photo-preview').css('background', 'url(' + uploadedImage.val() + ')');

            return true
        }

        return false

    }

    function readImage(){

        //Try read from upload, if any
        var uploadedSuccess = readUploadedPhoto();

    }

    readImage();

});