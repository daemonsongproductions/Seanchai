Seanchai.StorySectionsEditRoute = Seanchai.EditableRoute.extend({
  model: function(params) {
    return this.get('store').find_section(this.modelFor('story').get('id'), params.order);
  }
});