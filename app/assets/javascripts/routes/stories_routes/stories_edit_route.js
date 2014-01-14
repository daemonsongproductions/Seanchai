Seanchai.StoriesEditRoute = Seanchai.EditableRoute.extend({
  templateName: "stories/edit",
  model: function(params) {
    return this.get('store').find('story', params.story_id);
  }
});