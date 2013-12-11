Seanchai.StoriesNewController = Ember.ObjectController.extend({
  actions: {
    cancel: function(){
      this.get('parentView').hideNew();
    },

    submit: function(){
      var controller = this;

      event.preventDefault();

      this.get('model').save().then(
          // fulfill
          function(answer) {
            return controller.transitionToRoute('stories.show', answer);
          },
          // reject
          function(e) {
            controller.set("errorMsg", "We had a problem creating your story. Did you fill out the form completely?");
          });
    }
  }
});