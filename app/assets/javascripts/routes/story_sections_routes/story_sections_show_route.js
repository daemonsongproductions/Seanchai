Seanchai.StorySectionsShowRoute = Ember.Route.extend({
  model: function(params) {
    return this.get('store').find('story_section', params.id);
  }
});