Seanchai.StorySectionsIndexRoute = Ember.Route.extend({
  model: function(params) {
    return this.get('store').find('story_section', {story_id: this.modelFor('story').get('id')});
  }
});