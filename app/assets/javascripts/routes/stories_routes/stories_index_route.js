Seanchai.StoriesIndexRoute = Ember.Route.extend({
  model: function(params) {
    return this.get('store').findAll('story');
  }
});