
Seanchai.Router.map(function() {
  this.route("home");
  this.route("help");
  this.route("login");
  this.route("registration");

  this.resource('users', function() {
    this.resource('user', {path: ':username'});
    this.resource('edit_user', {path: ':username/edit'});
    this.resource('user_stories', {path: ':username/stories'});
  });

  this.resource('stories', function(){
    this.route('new');
    this.resource('stories_edit', {path: ':story_id/edit'});
  });
  this.resource('story', { path: '/story/:story_id' }, function() {
    this.resource('story_sections_index', {path: ''});
    this.resource('story_sections_new', {path: '/story/:story_id/story_sections/new'});
  });
  this.resource('story_section_show', {path: '/story/:story_id/:story_section_id'});

});


Seanchai.IndexRoute = Ember.Route.extend({
  redirect: function() {
    this.transitionTo('home');
  }
});
