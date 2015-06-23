/*
 *  Document   : upload.js
 *  Author     : Michael Winton
 *  Description: Custom script that configures dropzone uploads
 *
 *= require_self
 */

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
        $('.delete-photo').hide();
        $(this).attr('disabled', 'true');
        $('#uploadPitchCardImage').trigger('click');
    }

    function readUrl(input){
        if (input.files && input.files[0]){
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#upload-click').hide();
                $('.photo-preview').css('background', 'url(' + e.target.result + ')');
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

            $('#upload-click').hide();
            $('#uploadPitchCardImage').val('');
            $('.delete-photo').show();
            $('.photo-preview').css('background', 'url(' + uploadedImage.val() + ')');

        }
    }

    readUploadedPhoto();

});