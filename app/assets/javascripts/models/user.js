Seanchai.User = DS.Model.extend({
  username: DS.attr('string'),
  email: DS.attr('string'),
  name: DS.attr('string'),
  permit: DS.attr('string'),
  editable: DS.attr('boolean'),
  administrator: function() {
    if(this.get('permit') === "admin") {
      return true;
    }
    else {
      return false;
    }
  }.property('permit')
});