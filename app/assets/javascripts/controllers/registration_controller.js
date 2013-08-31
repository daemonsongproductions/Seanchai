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