Seanchai.EditUserRoute = Ember.Route.extend({
  templateName: "users/edit",
  model: function(params) {
    return this.get('store').find('user', params.username);
  },
  setupController: function(controller, model) {
    controller.set("content", model);
    controller.set("account_options",[
      Seanchai.InputOptions.create({name: "selected_role", value: "reader", label: "I just want to read.", selected: model.get('reader')}),
      Seanchai.InputOptions.create({name: "selected_role", value: "creator", label: "I want to create, too.", selected: model.get('creator')})
    ])
  },
  deactivate: function() {
    var controller = this.controllerFor('editUser');
    controller.get("model").rollback();
    controller.set("errorMsg", "");
  }
});