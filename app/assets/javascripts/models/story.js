Seanchai.Story = DS.Model.extend({
  title: DS.attr('string'),
  description: DS.attr('string'),
  copyright: DS.attr('string'),
  license: DS.attr('string'),
  creator_id: DS.attr('string'),
  editable: DS.attr('boolean'),
  status_id: DS.attr('number'),
  story_sections: DS.hasMany('story_section'),

  validate: function(){
    if(this.get('title') === undefined || this.get('title') === '') {
      return "You must give this story a title."
    }
  }
});