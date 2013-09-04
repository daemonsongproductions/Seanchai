Seanchai.ConfirmationTextField = Ember.View.extend({
  classNames:['control-group'],
  templateName: "fields/confirmation_text_field",
  fieldType: "text",
  invalid: function(){
    return ((this.confirmField.value !== this.value) || (0 === this.value.length));
  }.property("value")
});