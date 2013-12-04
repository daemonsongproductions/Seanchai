Seanchai.StoriesNewView = Ember.View.extend({
  tagName: 'form',
  templateName: "stories/new",

  didInsertElement: function() {
    this._super();
    this.$('input:first').focus();
  }
});