Seanchai.StorySectionFormView = Ember.View.extend({
  tagName: 'form',
  templateName: "story_sections/story_section_form",

  didInsertElement: function() {
    this._super();
    this.$('input:first').focus();
  }
});