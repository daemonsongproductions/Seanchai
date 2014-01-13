Seanchai.StorySectionsIndexController = Ember.ArrayController.extend({
  sortProperties: ['title'],
  sortAscending: true,
  needs: "story",
  story: Ember.computed.alias("controllers.story"),
  actions: {
    load_section: function(section) {
      this.transitionToRoute('story_sections_index', section);
    }
  }
});