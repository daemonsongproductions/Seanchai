Seanchai.User = DS.Model.extend({
  username: DS.attr('string'),
  email: DS.attr('string'),
  name: DS.attr('string'),
  permit: DS.attr('string'),
  editable: DS.attr('boolean'),
  role: DS.attr('string'),
  administrator: function() {
    if(this.get('permit') === "admin") {
      return true;
    }
    else {
      return false;
    }
  }.property('permit'),
  creator: function() {
    if(this.get('role') === "creator") {
      return true;
    }
    else {
      return false;
    }
  }.property('role'),
  reader: function() {
    if(this.get('role') === "reader") {
      return true;
    }
    else {
      return false;
    }
  }.property('role')
});