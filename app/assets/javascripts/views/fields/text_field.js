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
    var class_list = '';
    if (this.get('field-size') !== undefined)
      class_list += ' ' + this.get('field-size');
    return class_list + ' form-control';
  }.property()
});