Seanchai.RequiredTextField = Ember.View.extend({
  classNameBindings: [':control-group', 'invalid:has-error', ':col-sm-10'],
  templateName: "fields/required_text_field",
  type: "text",
  changed: false,
  invalid: true,
  classesBinding: 'classesProperty',
  validationMessage: function(){
    return this.label + " is required."
  }.property("displayValidationMessage"),
  focusOut: function(){
    this.set('changed', true);
  },
  formError: function(){
    this.set('changed', (this.get('controller').get('errorMsg')).length > 0)
  }.observes("controller.content.errorMsg"),
  displayValidationMessage: function(){
    return(this.get('invalid') && this.get('changed'));
  }.property("invalid", "changed"),
  isInvalid: function(){
    this.set('invalid', (0 === this.get('value').length));
  }.observes("value"),
  classesProperty: function() {
    return [this.get('field-size') + ' form-control'];
  }.property()
});