Seanchai.NavbarController = Ember.ObjectController.extend({
  authStateBinding: Ember.Binding.oneWay('Seanchai.LoginStateManager.currentState'),
  authState: null,
  authenticated: (function() {
    log.info("NavbarController authent");
    return this.get("authState") === Seanchai.LoginStateManager.authenticated;
  }).property("authState"),
  user: (function() {
    if (this.get("authState") === Seanchai.LoginStateManager.authenticated) {
      return Seanchai.currentUser;
    } else {
      return null;
    }
  }).property("authState"),
  actions: {
    logout: function() {
      var me;
      log.info("NavbarController handling logout event...");
      me = this;
      return Seanchai.Authentication.logout(function() {
        return me.transitionToRoute("home");
      });
    },
    profile: function() {
      this.transitionToRoute('user', this.get('user'))
    }
  }
});