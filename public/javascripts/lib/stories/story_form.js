var validation_rules  = {
  rules :{
      "story[title]": {required: true }
  },
  messages :{
      "story[title]": {
          required: "Your story needs a title. A working title, at least. Don't worry, you can change it."
      }
  },
  errorElement: "div",
  wrapper: "div",

  errorPlacement: function(error, element) {
    error.insertAfter(element.parent());
    error.addClass("message");
  }
};
$(document).ready(function() {
  $("#story_form").validate(validation_rules);

  $('#submit_button').click(function() {
      $('#story_form').valid();
  });
});