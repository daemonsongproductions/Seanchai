Seanchai.TextAreaField = Ember.View.extend({
  classNameBindings: [':form-group'],
  templateName: "fields/text_area_field",
  classesBinding: 'classesProperty',
  changed: false,
  focusOut: function(){
    this.set('changed', true);
  },
  classesProperty: function() {
    var class_list = '';
    if (this.get('field-size') !== undefined)
      class_list += ' ' + this.get('field-size');
    return class_list + ' tinymce form-control';
  }.property()
});