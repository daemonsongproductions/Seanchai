Seanchai.StorySection = DS.Model.extend({
  title: DS.attr('string'),
  body: DS.attr('string'),
  order: DS.attr('number'),
  //include_in_toc: DS.attr('string'),
  status_id: DS.attr('string'),
  editable: DS.attr('boolean'),
  story: DS.belongsTo('story',{async:true}),
  story_id: DS.attr('string'),
  partial: DS.attr('boolean'),

  validate: function(){
    if(this.get('title') === undefined || this.get('title') === '') {
      return "You must give this story a title."
    }
  }
});