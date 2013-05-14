Seanchai.StoriesController = Ember.ArrayController.extend({

  events: {
    showNew: function() {
      alert("poop");
    }
  },

  showNew: function() {
    this.set('isNewVisible', true);
  }
});