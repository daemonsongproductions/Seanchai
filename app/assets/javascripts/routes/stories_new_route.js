Seanchai.StoriesNewRoute = Ember.Route.extend({
  templateName: "stories/new",
  model: function(params) {
    return this.get('store').createRecord('story');
  }
});