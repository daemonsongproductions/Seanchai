Seanchai.StoriesIndexController = Ember.ArrayController.extend({


  hideNew: function() {
    this.set('isNewVisible', false);
  },

  showNew: function() {
    this.set('isNewVisible', true);
  }

});