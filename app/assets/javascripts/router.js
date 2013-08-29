Seanchai.Router.map(function(){
  this.route('home', {path: '/'});
  this.resource("stories", { path: '/stories/:story_id' });
  this.route("home");
  this.route("help");
  this.route("login");
  this.route("registration");
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
    return controller.set("errorMsg", "");
  },
  events: {
    cancel: function() {
      log.info("cancelling login");
      return this.transitionTo('home');
    },
    login: function() {
      log.info("Logging in...");
      return Seanchai.login(this);
    }
  }
});

Seanchai.StoriesRoute = Ember.Route.extend({
  model: function(){
    Seanchai.Story.find();
  }
});

var teams = [
     "Celtics",
     "Lakers",
     "Bulls"
];

Seanchai.HomeRoute = Ember.Route.extend({
  model: function(){
   return Seanchai.Story.find()
  },
  setupController: function(controller){
       controller.set('teams', Seanchai.Story.find());
  }
});


Seanchai.Router.reopen({
  location: 'history'
});
