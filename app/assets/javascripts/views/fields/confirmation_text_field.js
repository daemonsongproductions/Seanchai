Seanchai.ConfirmationTextField = Ember.View.extend({
  classNames:['control-group'],
  templateName: "fields/confirmation_text_field",
  fieldType: "text",
  invalid: function(){
    return ( this.missing(this) || this.different(this));
  }.property("value", "confirmField.value"),
  missing: function(view) {
    return (0 === view.value.length);
  },
  different: function(view) {
    debugger;
    return (view.confirmField.value !== view.value);
}
});