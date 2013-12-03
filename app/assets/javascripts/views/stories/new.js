Seanchai.NewStoryView = Ember.View.extend({
  tagName: 'form',
  templateName: 'stories/edit',

  init: function() {
    this._super();
    this.set('story', Seanchai.Story.createRecord());
  },

  didInsertElement: function() {
    this._super();
    this.$('input:first').focus();
  },

  cancel: function(){
    this.get('parentView').hideNew();
  },

  submit: function(){
    var self = this;
    var story = this.get('story');

    event.preventDefault();

    story.saveResource()
            .fail(function(e) {
              Seanchai.displayError(e);
            })
            .done(function() {
              Seanchai.storiesController.pushObject(story);
              self.get('parentView').hideNew();
            });
  }
});