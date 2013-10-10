Seanchai.User = DS.Model.extend({
  username: DS.attr('string'),
  email: DS.attr('string'),
  editable: DS.attr('boolean')
});