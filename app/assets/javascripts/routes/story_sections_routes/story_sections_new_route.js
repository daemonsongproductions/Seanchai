Seanchai.StorySectionsNewRoute = Ember.Route.extend({
  model: function(params) {
    return this.get('store').createRecord('story_section', {story_id: params['story_id']});
  }
});