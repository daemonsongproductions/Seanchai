
Seanchai.Router.map(function() {
  this.route("home");
  this.route("help");
  this.route("login");
  return this.route("registration");
});

Seanchai.IndexRoute = Ember.Route.extend({
  redirect: function() {
    return this.transitionTo('home');
  }
});

Seanchai.LoginRoute = Ember.Route.extend({
  model: function() {
    return Ember.Object.create();
  },
  setupController: function(controller, model) {
    controller.set('content', model);
    return controller.set("errorMsg", "");
  },
  events: {
    cancel: function() {
      log.info("cancelling login");
      return this.transitionTo('home');
    },
    login: function() {
      log.info("Logging in...");
      return Seanchai.Authentication.login(this);
    }
  }
});

Seanchai.RegistrationRoute = Ember.Route.extend({
  model: function() {
    return Ember.Object.create();
  },
  events: {
    register: function() {
      log.info("Registering...");
      return Seanchai.Authentication.register(this);
    },
    cancel: function() {
      log.info("cancelling registration");
      return this.transitionTo('home');
    }
  }
});
