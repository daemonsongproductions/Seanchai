Seanchai.RequiredTextField = Ember.View.extend({
  classNameBindings: [':form-group', 'invalid:has-error'],
  templateName: "fields/required_text_field",
  type: "text",
  changed: false,
  invalid: false,
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
    var class_list = '';
    if (this.get('field-size') !== undefined)
      class_list += ' ' + this.get('field-size');
    return class_list + ' form-control';
  }.property()
});