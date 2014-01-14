Seanchai.TextAreaField = Ember.View.extend({
  classNameBindings: [':form-group'],
  templateName: "fields/text_area_field",
  classesBinding: 'classesProperty',
  changed: false,
  focusOut: function(){
    this.set('changed', true);
  },
  classesProperty: function() {
    return [this.get('field-size') + ' tinymce form-control'];
  }.property()
});