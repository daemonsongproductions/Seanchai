var validation_rules  = {
    rules :{
        "email": {required: true, email: true },
        "password": {required: true, minlength: 6},
        "confirm_password": {required: true, equalTo: "#password" }
    },
    messages :{
        "email": {
            required: "Email address is required",
            email:"Email address format is invalid"
        },
        "password": {
            required: "Password is required.",
            minlength: "Password must be at least six characters long"
        },
        "confirm_password": {
            required: "Password is required.",
            equalTo: "Passwords must match."
        }
    }
};

$(document).ready(function(){
    $("#registration_form").validate(validation_rules);

    $('#submit_button').click(function() {
        $('#registration_form').valid();
    });
});