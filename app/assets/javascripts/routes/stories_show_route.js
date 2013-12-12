Seanchai.StoryRoute = Ember.Route.extend({
  templateName: "stories/show",
  model: function(params) {
    return this.get('store').find('story', params.story_id);
  }
});