Seanchai.StorySectionsIndexController = Ember.ArrayController.extend({
  sortProperties: ['title'],
  sortAscending: true,
  needs: "story",
  section: function() {
    return this.find(function(section) {
      return (section.get('id') == "this");
    });
  }.property('model')
});