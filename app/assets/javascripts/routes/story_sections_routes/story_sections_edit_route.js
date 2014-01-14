Seanchai.StorySectionsEditRoute = Seanchai.EditableRoute.extend({
  model: function(params) {
    return this.get('store').find('story_section', {order: params.order, story_id: this.modelFor('story').get('id')});
  }
});