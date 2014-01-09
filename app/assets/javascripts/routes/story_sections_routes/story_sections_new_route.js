Seanchai.StorySectionsNewRoute = Ember.Route.extend({
  model: function(params) {
    return this.get('store').createRecord('story_section');
  }
});