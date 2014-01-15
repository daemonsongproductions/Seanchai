Seanchai.StoriesEditRoute = Seanchai.EditableRoute.extend({
  templateName: "stories/edit",
  model: function(params) {
    return this.get('store').find('story', params.story_id);
  },
  setupController: function(controller, model) {
    controller.set('model', model );
    var statuses = this.get('store').find('status');
    statuses.then(function(data) {
      controller.set('statuses', data);
    });
  }
});