// Remove this file eventually, but for now I'm saving it as an example
// of how to have a function update when it's bound to a .property("likethis")
Seanchai.RegistrationController = Ember.ObjectController.extend({
  actions: {
    register: function() {
      log.info("Registering...");
      Seanchai.Authentication.register(this);
    },
    cancel: function() {
      log.info("cancelling registration");
      this.transitionToRoute('home');
    }
  },
  account_options: [
    Seanchai.InputOptions.create({name: "selected_role", value: "reader", label: "I just want to read.", selected: true}),
    Seanchai.InputOptions.create({name: "selected_role", value: "writer", label: "I want to create, too.", selected: false})
  ]

});
