Seanchai.StoriesNewController = Ember.ObjectController.extend({
  actions: {
    cancel: function(){
      this.get('parentView').hideNew();
    },

    submit: function(){
      var story = this.get('model');
      var controller = this;

      event.preventDefault();

      story.save().then(
          // fulfill
          function() {
            Seanchai.storiesController.pushObject(story);
          },
          // reject
          function(e) {
            controller.set("errorMsg", "We had a problem creating your story. Did you fill out the form completely?");
          });
    }
  }
});