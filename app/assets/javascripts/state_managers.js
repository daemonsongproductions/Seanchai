Seanchai.LoginStateManager = Ember.StateManager.create({
  initialState: 'notAuthenticated',
  authenticated: Ember.State.create({
    enter: function() {
      return log.info("LoginStateManager enter state: " + this.name);
    },
    logout: function(manager, context) {
      return manager.transitionTo('notAuthenticated');
    }
  }),
  notAuthenticated: Ember.State.create({
    enter: function() {
      return log.info("LoginStateManager enter state: " + this.name);
    },
    login: function(manager, credentials) {
      return manager.transitionTo('authenticated');
    },
    register: function(manager, credentials) {
      return manager.transitionTo('authenticated');
    }
  })
});