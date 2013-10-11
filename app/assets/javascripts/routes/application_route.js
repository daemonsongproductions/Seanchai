Seanchai.ApplicationRoute = Ember.Route.extend({
  model: function(params) {
    return this.get('store').findAll('current_user');
  },
  afterModel: function(currentUser) {
    Seanchai.initApp(currentUser.get('firstObject'));
  }
});