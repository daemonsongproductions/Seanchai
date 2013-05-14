Seanchai.Story = DS.Model.extend({
  title: DS.attr('string'),

  validate: function(){
    if(this.get('title') === undefined || this.get('title') === '') {
      return "You must give this story a title."
    }
  }
});