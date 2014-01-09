Seanchai.StorySectionsIndexController = Ember.ArrayController.extend({
  sortProperties: ['title'],
  sortAscending: true,
  needs: "story",
  post: Ember.computed.alias("controllers.story")
});