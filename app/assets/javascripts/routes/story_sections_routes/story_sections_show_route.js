Seanchai.StorySectionsShowRoute = Ember.Route.extend({
  model: function(params) {
    return this.get('store').find_section(this.modelFor('story').get('id'), params.order);
  },
  setupController: function(controller, model) {
    if (model.get('partial')) {
      model.reload();
    }
    controller.set('model', model);

    if (model.get('next_section')) {
      var next_section = this.get('store').find_section(model.get('story_id'), model.get('next_section'));
      next_section.then(function(data) {
        if(data) {
          controller.set('next_section_visible', true);
        }
        else {
          controller.set('next_section_visible', false);
        }
      });
    }

    if (model.get('previous_section')) {
      var previous_section = this.get('store').find_section(model.get('story_id'),model.get('previous_section'));

      previous_section.then(function(data) {
        if(data) {
          controller.set('previous_section_visible', true);
        }
        else {
          controller.set('previous_section_visible', false);
        }
      });
    }
  }
});