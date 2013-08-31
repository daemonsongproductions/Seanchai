// Remove this file eventually, but for now I'm saving it as an example
// of how to have a function update when it's bound to a .property("likethis")
Seanchai.RegistrationController = Ember.ObjectController.extend({
  recoveryOptions: ['Email', "None"],
  selectedRecoveryOption: "Email",
  recoverByEmail: function() {
    if (this.selectedRecoveryOption === "Email") {
      return true;
    }
    else {
      return false;
    }
  }.property("selectedRecoveryOption")
});