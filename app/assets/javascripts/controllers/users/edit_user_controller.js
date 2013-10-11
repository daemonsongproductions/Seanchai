Seanchai.EditUserController = Ember.ObjectController.extend({

  actions: {
    cancel: function() {
      log.info("cancelling user edit");
      this.transitionToRoute('user', this);
    },
    submit: function() {
      log.info("submitting user update...");
      this.modelFor('editUser').save().then(null, function() {
        this.transitionToRoute('user', this);
      });
    }
  }

});