Seanchai.TextAreaField = Ember.View.extend({
  classNameBindings: [':form-group'],
  templateName: "fields/text_area_field",
  type: "text",
  classesBinding: 'classesProperty',
  didInsertElement: function() {
    tinyMCE.init({"selector":"textarea.tinymce"});
  },
  changed: false,
  focusOut: function(){
    this.set('changed', true);
  },
  classesProperty: function() {
    return [this.get('field-size') + ' tinymce form-control'];
  }.property()
});