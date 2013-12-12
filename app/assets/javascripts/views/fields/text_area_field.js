Seanchai.TextAreaField = Ember.View.extend({
  classNameBindings: [':control-group'],
  templateName: "fields/text_area_field",
  type: "text",
  classesBinding: 'classesProperty',
  changed: false,
  focusOut: function(){
    this.set('changed', true);
  },
  classesProperty: function() {
    return [this.get('field-size') + ' form-control'];
  }.property()
});