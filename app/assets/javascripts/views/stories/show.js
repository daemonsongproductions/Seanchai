Seanchai.ShowStoryView = Ember.View.extend({
  templateName: "stories/show",
  className: ['show-story'],
  tagName: 'tr',

  doubleClick: function() {
    this.showEdit();
  },

  showEdit: function() {
    this.set('isEditing', true);
  },

  hideEdit: function() {
    this.set('isEditing', false);
  }

});