
Seanchai.Router.map(function() {
  this.route("home");
  this.route("help");
  this.route("login");
  this.route("registration");
});

Seanchai.IndexRoute = Ember.Route.extend({
  redirect: function() {
    this.transitionTo('home');
  }
});

Seanchai.LoginRoute = Ember.Route.extend({
  model: function() {
    return Ember.Object.create();
  },
  setupController: function(controller, model) {
    controller.set('content', model);
    controller.set("errorMsg", "");
  },
  events: {
    cancel: function() {
      log.info("cancelling login");
      this.transitionTo('home');
    },
    login: function() {
      log.info("Logging in...");
      Seanchai.Authentication.login(this);
    }
  }
});

Seanchai.RegistrationRoute = Ember.Route.extend({
  model: function() {
    return Ember.Object.create();
  }
});
