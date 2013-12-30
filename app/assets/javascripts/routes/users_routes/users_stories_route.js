Seanchai.UserStoriesRoute = Ember.Route.extend({
  model: function(params) {
    return this.get('store').find('story', {username: params.username});
  }
});