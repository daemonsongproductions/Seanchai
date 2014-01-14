Seanchai.TinymceView = Ember.TextArea.extend({
  editor: null,
  _suspendValueChange: false,
  didInsertElement: function(){
    var id = "#" + this.get("elementId");
    var view = this;
    tinymce.init({
      selector: id,
      setup : function(ed) {
        view.set("editor", ed);
        ed.on("keyup change", function() {
          view.suspendValueChange(function() {
            view.set("value", ed.getContent());
          });
        });
      }
    });
  },
  suspendValueChange: function(cb) {
    this._suspendValueChange = true;
    cb();
    this._suspendValueChange = false;
  },
  valueChanged: function() {
    if (this._suspendValueChange) { return; }
    var content = this.get("value");
    this.get("editor").setContent(content);
  }.observes("value"),
  willClearRender: function() {
    this.get("editor").remove();
    console.log("Editor removed");
  }
});