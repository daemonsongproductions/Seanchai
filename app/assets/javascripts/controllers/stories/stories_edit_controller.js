Seanchai.StoriesEditController = Ember.ObjectController.extend({
  actions: {
    cancel: function(){
      this.transitionToRoute('story_sections_index', this);
    },

    submit: function(){
      var controller = this;

      event.preventDefault();

      this.get('model').save().then(
          // fulfill
          function(answer) {
            return controller.transitionToRoute('story', answer);
          },
          // reject
          function(e) {
            controller.set("errorMsg", "We had a problem creating your story. Did you fill out the form completely?");
          });
    }
  }
});