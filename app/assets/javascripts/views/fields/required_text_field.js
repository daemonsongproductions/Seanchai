Seanchai.RequiredTextField = Ember.View.extend({
  classNames:['control-group'],
  templateName: "fields/required_text_field",
  isValid: function(){
    return (!inputElement || 0 === inputElement.length)
  }.property("inputElement.elementId")
});