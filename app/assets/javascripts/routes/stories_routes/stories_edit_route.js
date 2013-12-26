Seanchai.StoriesEditRoute = Ember.Route.extend({
  templateName: "stories/edit",
  model: function(params) {
    return this.get('store').find('story', params.story_id);
  }
});