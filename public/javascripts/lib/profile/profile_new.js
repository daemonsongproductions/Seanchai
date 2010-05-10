$(document).ready(function(){
    $("#registration_form").validate();

    $('#submit_button').click(function() {
        $('#registration_form').valid();
    });
});