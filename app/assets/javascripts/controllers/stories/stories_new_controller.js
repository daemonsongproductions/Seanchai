Seanchai.StoriesNewController = Ember.ObjectController.extend({
  actions: {
    cancel: function(){
      this.get('parentView').hideNew();
    },

    submit: function(){
      var story = this.get('model');

      event.preventDefault();

      story.save().then(
          // fulfill
          function() {
            Seanchai.storiesController.pushObject(story);
          },
          // reject
          function(e) {
            Seanchai.displayError(e);
          });
    }
  }
});