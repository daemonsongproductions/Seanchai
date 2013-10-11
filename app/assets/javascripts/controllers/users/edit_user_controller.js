Seanchai.EditUserController = Ember.ObjectController.extend({

  actions: {
    cancel: function() {
      log.info("cancelling user edit");
      this.transitionToRoute('user', this);
    },
    save: function() {
      log.info("submitting user update...");
      this.save().then(null, function() {
        this.transitionToRoute('user', this);
      });
    }
  }

});