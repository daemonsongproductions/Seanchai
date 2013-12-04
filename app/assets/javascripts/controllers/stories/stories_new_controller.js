Seanchai.StoriesNewController = Ember.ObjectController.extend({
  actions: {
    cancel: function(){
      this.get('parentView').hideNew();
    },

    submit: function(){
      var story = this.get('model');

      event.preventDefault();

      story.save()
          .fail(function(e) {
            Seanchai.displayError(e);
          })
          .done(function() {
            Seanchai.storiesController.pushObject(story);
          });
    }
  }
});