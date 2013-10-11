Seanchai.UserController = Ember.ObjectController.extend({

  isMe: function(){
    return Seanchai.currentUser.get('username') === this.get('username');
  }.property("this"),
  canEdit: function(){
    debugger;
    return (this.get('isMe') === true || Seanchai.currentUser.get('administrator') === true )
  }.property("this")
});