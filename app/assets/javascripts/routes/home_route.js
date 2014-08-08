Seanchai.HomeRoute = Ember.Route.extend ({
  model: function(params) {
    var username = "";
    if (Seanchai.currentUser) {
      username = Seanchai.currentUser.get('username');
    }

    return Ember.RSVP.hash({
      recent_stories: this.get('store').find('story', {limit: 5, order_by: 'updated_at', direction: 'desc'}),
      reading_list: [],
      published_stories: this.get('store').find('story', {limit: 5, order_by: 'updated_at', direction: 'desc', username: username, status: 'published'}),
      drafts: this.get('store').find('story', {limit: 5, order_by: 'updated_at', direction: 'desc', username: username, status: 'draft'})
    });
  },
  setupController: function(controller, model) {

    // apparently we have to set content. For now, it's empty.
    controller.set('content', {});

    controller.set('recent_stories', model['recent_stories']);
    //controller.set('reading_list', model['reading_list']);
    controller.set('published_stories', model['published_stories']);
    controller.set('drafts', model['drafts']);

  }
});