
Seanchai.Router.map(function() {
  this.route("home");
  this.route("help");
  this.route("login");
  this.route("registration");

  this.resource('users', function() {
    this.resource('user', {path: ':username'})
    this.resource('edit_user', {path: ':username/edit'})
  });

  this.resource('stories', function(){
    this.route('new');
  });

});


Seanchai.IndexRoute = Ember.Route.extend({
  redirect: function() {
    this.transitionTo('home');
  }
});
