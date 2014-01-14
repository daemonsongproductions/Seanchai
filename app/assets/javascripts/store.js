Seanchai.Store = DS.Store.extend({
  find_section: function(story_id, order) {
    return this.find('story_section', order + "?story_id=" + story_id)
  }
});

