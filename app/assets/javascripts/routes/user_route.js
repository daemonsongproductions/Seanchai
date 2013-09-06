Seanchai.UserRoute = Ember.Route.extend({
  templateName: "users/user",
  model: function(params) {
    return this.store.find('user', params.username);
  }
});