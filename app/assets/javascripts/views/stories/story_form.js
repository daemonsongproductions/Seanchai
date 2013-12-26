Seanchai.StoryFormView = Ember.View.extend({
  tagName: 'form',
  templateName: "stories/story_form",

  didInsertElement: function() {
    this._super();
    this.$('input:first').focus();
  }
});