Seanchai.RequiredTextField = Ember.View.extend({
  classNames:['control-group'],
  templateName: "fields/required_text_field",
  isValid: function(){
    return (0 !== this.value.length);
  }.property("value")
});