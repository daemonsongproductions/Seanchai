Seanchai.EditableRoute = Ember.Route.extend({

  actions: {
    willTransition: function(transition) {
      if (this.controllerFor(transition.targetName).get('isDirty') &&
          !confirm("Are you sure you want to abandon progress?")) {
        transition.abort();
        return false;
      } else {
        this.get('currentModel').rollback();
        return true;
      }
    }
  }
});