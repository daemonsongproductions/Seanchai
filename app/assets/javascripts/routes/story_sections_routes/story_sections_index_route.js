Seanchai.StorySectionsIndexRoute = Ember.Route.extend({
  model: function(params) {
    return this.modelFor('story').get('story_sections');
  }
});