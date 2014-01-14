Seanchai.StorySectionsShowRoute = Ember.Route.extend({
  model: function(params) {
    //return this.get('store').find('story_section', {order: params.order, story_id: this.modelFor('story').get('id')});
    return this.get('store').find_section(this.modelFor('story').get('id'), params.order);
  }
});