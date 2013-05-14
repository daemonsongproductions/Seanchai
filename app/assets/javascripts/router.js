Seanchai.Router.map(function(){
  this.resource("stories", function(){
    this.route('new');
  });
});

Seanchai.StoriesRoute = Ember.Route.extend({
  model: function(){
    Seanchai.Story.find();
  }
});


Seanchai.Router.reopen({
  location: 'history'
});
