Seanchai.WelcomeMsgController = Ember.ObjectController.extend({
  authStateBinding: Ember.Binding.oneWay('Seanchai.LoginStateManager.currentState'),
  authState: null,
  user: (function() {
    if (this.get("authState") === Seanchai.LoginStateManager.authenticated) {
      return Seanchai.currentUser;
    } else {
      return null;
    }
  }).property("authState")
});