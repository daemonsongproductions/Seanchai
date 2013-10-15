Seanchai.EditUserController = Ember.ObjectController.extend({

  clearErrorMsg: function() {
    this.set("errorMsg", "");
  }.property("content"),

  actions: {
    cancel: function() {
      log.info("cancelling user edit");
      //this.clearErrorMsg();
      this.transitionToRoute('user', this);
    },
    save: function() {
      log.info("submitting user update...");
      var controller = this;
      this.get("model").save().then(
        function(answer) {
          //controller.clearErrorMsg();
          return controller.transitionToRoute('user', answer);
      },
        function(answer){
          controller.set("errorMsg", answer.responseJSON["error_message"]);
      });
    }
  }

});