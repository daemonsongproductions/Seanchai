Seanchai.TextField = Ember.View.extend({
  classNameBindings: [':form-group'],
  templateName: "fields/text_field",
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