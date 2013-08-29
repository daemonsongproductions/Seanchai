Seanchai.RegistrationRoute = Ember.Route.extend({
  model: function() {
    Ember.Object.create();
  },
  events: {
    register: function() {
      log.info("Registering...");
      Seanchai.register(this);
    },
    cancel: function() {
      log.info("cancelling registration");
      this.transitionTo('home');
    }
  }
});