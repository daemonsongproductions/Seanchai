Seanchai.EditStoryView = Ember.View.extend({
  tagName: 'form',
  templateName: 'stories/edit',

  init: function() {
    this._super();
    // Create a new story that's a duplicate of the story in the parentView;
    // Changes made to the duplicate won't be applied to the original unless
    // everything goes well in submitForm()
    this.set("story", this.get('parentView').get('story').copy());
  },

  didInsertElement: function() {
    this._super();
    this.$('input:first').focus();
  },

  cancelForm: function() {
    this.get('parentView').hideEdit();
  },

  submit: function() {
    var self = this;
    var story = this.get("story");

    event.preventDefault();

    story.saveResource()
            .fail(function(e){
              Seanchai.displayError(e);
            })
            .done(function(){
              var parentView = self.get("parentView");
              parentView.get('story').duplicateProperties(story);
              parentView.hideEdit();
            });
  }

});