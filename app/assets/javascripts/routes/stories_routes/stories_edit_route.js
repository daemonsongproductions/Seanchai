Seanchai.StoriesEditRoute = Ember.Route.extend({
  templateName: "stories/edit",
  model: function(params) {
    return this.get('store').find('story', params.story_id);
  },
  actions: {
    willTransition: function(transition) {
      controller = this.controllerFor('story');
      if (controller.get('isDirty') &&
          !confirm("Are you sure you want to abandon progress?")) {
        transition.abort();
        return false;
      } else {
        this.get('currentModel').rollback();
        return true;
      }
    }
  }
});