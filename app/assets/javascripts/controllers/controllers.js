
Seanchai.NavbarController = Ember.ObjectController.extend({
  authStateBinding: Ember.Binding.oneWay('Seanchai.LoginStateManager.currentState'),
  authState: null,
  authenticated: (function() {
    log.info("NavbarController authent");
    return this.get("authState") === Seanchai.LoginStateManager.authenticated;
  }).property("authState"),
  logout: function() {
    var me;
    log.info("NavbarController handling logout event...");
    me = this;
    return Seanchai.Authentication.logout(function() {
      return me.transitionToRoute("home");
    });
  }
});

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
