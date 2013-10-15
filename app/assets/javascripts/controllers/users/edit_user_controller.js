Seanchai.EditUserController = Ember.ObjectController.extend({

  actions: {
    cancel: function() {
      log.info("cancelling user edit");
      this.transitionToRoute('user', this);
    },
    save: function() {
      log.info("submitting user update...");
      var controller = this;
      this.get("model").save().then(function(answer) {
        return controller.transitionToRoute('user', answer);
      });
    }
  }

});