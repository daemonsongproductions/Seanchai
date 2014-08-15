Seanchai.RadioButtons = Ember.View.extend({
  classNameBindings: [':form-group'],
  templateName: "fields/radio_buttons",
  type: "radio",
  classesBinding: 'classesProperty',
  changed: false,
  focusOut: function(){
    this.set('changed', true);
  },
  didInsertElement: function() {
    this.get('options').forEach(function(element){
      if (element.get('selected') == true) {
        this.set('value', element.get('value'));
      }
    }, this);
  }
});