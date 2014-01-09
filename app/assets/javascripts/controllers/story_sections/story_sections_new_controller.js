Seanchai.StorySectionsNewController = Ember.ObjectController.extend({
  actions: {
    cancel: function(){
      this.transitionToRoute('story_sections_index');
    },

    submit: function(){
      var controller = this;

      event.preventDefault();

      this.get('model').save().then(
          // fulfill
          function(answer) {
            return controller.transitionToRoute('story_sections_index', answer);
          },
          // reject
          function(e) {
            controller.set("errorMsg", "We had a problem creating your story. Did you fill out the form completely?");
          });
    }
  }
});