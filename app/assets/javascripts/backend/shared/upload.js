/*
 *  Document   : upload.js
 *  Author     : Michael Winton
 *  Description: Custom script that configures dropzone uploads
 *
 *= require_self
 */

$(function() {

    $('#upload-click').click(function (){
        imageClick();
    });

    $('.delete-photo').click(function (e){
        e.preventDefault();
        deletePhoto();
    });

    function imageClick(){
        $('.delete-photo').hide();
        $('.photo-preview').click(function(){
            $(this).attr('disabled', 'true');
            $('#uploadPitchCardImage').trigger('click');
        });

        $('#uploadPitchCardImage').change(function(){
            $('.photo-preview').removeAttr('disabled');
            readUrl(this);
        })
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
        $('.delete-photo').click(function(){
            $('.delete-photo').hide();
            $('#uploadPitchCardImage').val('');
            $('.photo-preview').css('background', '');
            $('#upload-click').show();
        });
    }

});