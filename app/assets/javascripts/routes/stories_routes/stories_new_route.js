Seanchai.StoriesNewRoute = Ember.Route.extend({
  model: function(params) {
    return this.get('store').createRecord('story');
  },
  setupController: function(controller, model) {
    controller.set('model', model );
    var statuses = this.get('store').find('status');
    statuses.then(function(data) {
      controller.set('statuses', data);
    });
  }
});