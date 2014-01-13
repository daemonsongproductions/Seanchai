Seanchai.StorySectionsShowRoute = Ember.Route.extend({
  model: function(params) {
    var the_story = this.modelFor('story');
    var route = this;
    this.get('store').find('story', params.story_id).then(function(answer){
      var story = route.get('store').createRecord('story', answer);
      return story.get('story_sections').find(params.id);
    });

  }
});