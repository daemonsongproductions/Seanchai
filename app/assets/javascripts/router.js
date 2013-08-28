Seanchai.Router.map(function(){
  this.route('home', {path: '/'});
  this.resource("stories", { path: '/stories/:story_id' });

  this.resource('admin', function(){
    this.route('index');
    this.resource('stories', function(){
    });
  });

});

Seanchai.IndexRoute = Ember.Route.extend({
  model: function() {
    return ['foo', 'bar'];
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
