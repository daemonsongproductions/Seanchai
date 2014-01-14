Seanchai.StorySectionsEditController = Ember.ObjectController.extend({
  actions: {
    cancel: function(){
      this.transitionToRoute('story_sections_show', this);
    },

    submit: function(){
      var controller = this;

      event.preventDefault();

      this.get('model').save().then(
          // fulfill
          function(answer) {
            return controller.transitionToRoute('story_sections_show', answer);
          },
          // reject
          function(e) {
            controller.set("errorMsg", "We were unable to save this record.");
          });
    }
  }
});