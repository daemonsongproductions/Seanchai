Seanchai.StorySectionsIndexController = Ember.ArrayController.extend({
  sortProperties: ['title'],
  sortAscending: true,
  needs: "story",
  story: Ember.computed.alias("controllers.story")
});