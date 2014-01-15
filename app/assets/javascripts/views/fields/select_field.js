Seanchai.SelectField = Ember.View.extend({
  classNameBindings: [':form-group'],
  templateName: "fields/select_field",
  classesBinding: 'classesProperty',
  changed: false,
  focusOut: function(){
    this.set('changed', true);
  },
  classesProperty: function() {
    return [this.get('field-size') + ' input-sm form-control'];
  }.property()
});