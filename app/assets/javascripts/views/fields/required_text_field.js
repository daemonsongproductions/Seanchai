Seanchai.RequiredTextField = Ember.View.extend({
  classNameBindings: [':control-group', 'invalid:error'],
  templateName: "fields/required_text_field",
  type: "text",
  changed: false,
  invalid: true,
  validationMessage: function(){
    return this.label + " is required."
  }.property("displayValidationMessage"),
  focusOut: function(){
    this.set('changed', true);
  },
  displayValidationMessage: function(){
    return(this.get('invalid') && this.get('changed'));
  }.property("invalid", "changed"),
  isInvalid: function(){
    this.set('invalid', (0 === this.get('value').length));
  }.observes("value")
});