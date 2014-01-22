Seanchai.Store = DS.Store.extend({
  find_section: function(story_slug, order) {
    return this.find('story_section', order + "?story_id=" + story_slug);
    //var adapter = this.adapterFor('story_section')
    //return adapter.ajax(adapter.buildURL('story_section', order), 'GET', {data: {story_id: story_slug}});
  }
});

Seanchai.ApplicationAdapter = DS.RESTAdapter.extend({
  pathForType: function(type) {
    var underscored = Ember.String.underscore(type)
    return Ember.String.pluralize(underscored);
  }
});


Seanchai.ApplicationSerializer = DS.ActiveModelSerializer.extend({});