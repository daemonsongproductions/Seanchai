
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
  }
});

Seanchai.RegistrationRoute = Ember.Route.extend({
  model: function() {
    return Ember.Object.create({email: "", username:"", password: "", password_confirmation: ""});
  }
});
