Seanchai.EditUserRoute = Ember.Route.extend({
  templateName: "users/edit",
  model: function(params) {
    return this.get('store').find('user', params.username);
  },
  deactivate: function() {
    var controller = this.controllerFor('editUser');
    controller.get("model").rollback();
    controller.set("errorMsg", "");
  }
});