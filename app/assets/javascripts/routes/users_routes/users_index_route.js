Seanchai.UsersIndexRoute = Ember.Route.extend({
  model: function(params) {
    return this.get('store').findAll('user');
  }
});