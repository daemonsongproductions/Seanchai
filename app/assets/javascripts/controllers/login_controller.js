Seanchai.LoginController = Ember.ObjectController.extend({

  actions: {
    cancel: function() {
      log.info("cancelling login");
      this.transitionToRoute('home');
    },
    login: function() {
      log.info("Logging in...");
      Seanchai.Authentication.login(this);
    }
  }

});