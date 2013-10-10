Seanchai.EditUserRoute = Ember.Route.extend({
  templateName: "users/edit",
  model: function(params) {
    return this.get('store').find('user', params.username);
  }
});