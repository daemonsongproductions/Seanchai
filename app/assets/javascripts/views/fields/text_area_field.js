Seanchai.TextAreaField = Ember.View.extend({
  classNameBindings: [':control-group'],
  templateName: "fields/text_area_field",
  type: "text",
  changed: false,
  focusOut: function(){
    this.set('changed', true);
  }
});