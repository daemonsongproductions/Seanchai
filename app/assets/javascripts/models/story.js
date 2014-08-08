Seanchai.Story = DS.Model.extend({
  title: DS.attr('string'),
  description: DS.attr('string'),
  copyright: DS.attr('string'),
  license: DS.attr('string'),
  creator_id: DS.attr('string'),
  editable: DS.attr('boolean'),
  status_id: DS.attr('string'),
  story_sections: DS.hasMany('story_section',{async:true}),
  publication_date: DS.attr('date'),
  updated_at: DS.attr('date'),
  pretty_date: function(attribute) {
    return moment(this.get(attribute)).fromNow();
  },
  validate: function(){
    if(this.get('title') === undefined || this.get('title') === '') {
      return "You must give this story a title."
    }
  }
});