Seanchai.RegistrationRoute = Ember.Route.extend({
  model: function() {
    return Ember.Object.create({email: "", username:"", password: "", password_confirmation: "", selected_role: ""});
  }
});
