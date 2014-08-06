Seanchai.HomeRoute = Ember.Route.extend ({
  model: function(params) {
    if (Seanchai.currentUser) {
      return Ember.RSVP.hash({
        recent_stories: [],
        reading_list: [],
        published_stories: [],
        drafts: []
      });
    }
    else {
      return {};
    }
  },
  setupController: function(controller, model) {
    controller.set('content', Seanchai.currentUser);
    controller.set('recent_stories', model['recent_stories']);
    controller.set('reading_list', model['reading_list']);
    controller.set('published_stories', model['published_stories']);
    controller.set('drafts', model['drafts']);
  }
});