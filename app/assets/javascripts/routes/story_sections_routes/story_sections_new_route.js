Seanchai.StorySectionsNewRoute = Ember.Route.extend({
  model: function(params) {
    return this.get('store').createRecord('story_section', {story_id: params['story_id']});
  },
  setupController: function(controller, model) {
    controller.set('model', model );
    var statuses = this.get('store').find('status');
    statuses.then(function(data) {
      controller.set('statuses', data);
    });
  }
});