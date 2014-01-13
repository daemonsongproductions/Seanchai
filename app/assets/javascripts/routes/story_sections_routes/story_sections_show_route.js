Seanchai.StorySectionsShowRoute = Ember.Route.extend({
  model: function(params) {
    return this.get('store').find('story_section', {id: params.id, story_id: this.modelFor('story').get('id')});
  }
});