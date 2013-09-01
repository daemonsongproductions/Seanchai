
Seanchai.Authentication || (Seanchai.Authentication = {});

Seanchai.Authentication.login = function(controller) {
  return $.ajax({
    url: Seanchai.urls.login,
    type: "POST",
    data: {
      "user[username]": controller.get('username'),
      "user[password]": controller.get('password')
    },
    success: function(data) {
      log.log("Login Msg " + data.user.dummy_msg);
      Seanchai.currentUser = data.user;
      Seanchai.LoginStateManager.transitionTo("authenticated");
      return controller.transitionToRoute('home');
    },
    error: function(jqXHR, textStatus, errorThrown) {
      if (jqXHR.status === 401) {
        return controller.set("errorMsg", "That email/password combo didn't work.  Please try again");
      } else if (jqXHR.status === 406) {
        return controller.set("errorMsg", "Request not acceptable (406):  make sure Devise responds to JSON.");
      } else {
        return p("Login Error: " + jqXHR.status + " | " + errorThrown);
      }
    }
  });
};

Seanchai.Authentication.register = function(controller) {
  return $.ajax({
    url: Seanchai.urls.register,
    type: "POST",
    data: {
      "user[username]": controller.get('username'),
      "user[email]": controller.get('email'),
      "user[password]": controller.get('password'),
      "user[password_confirmation]": controller.get('password_confirmation')
    },
    success: function(data) {
      Seanchai.currentUser = data.user;
      Seanchai.LoginStateManager.transitionTo("authenticated");
      return controller.transitionToRoute('home');
    },
    error: function(jqXHR, textStatus, errorThrown) {
      return controller.set("errorMsg", "That email/password combo didn't work.  Please try again");
    }
  });
};

Seanchai.Authentication.logout = function(transition) {
  log.info("Logging out...");
  return $.ajax({
    url: Seanchai.urls.logout,
    type: "DELETE",
    dataType: "json",
    success: function(data, textStatus, jqXHR) {
      $('meta[name="csrf-token"]').attr('content', data['csrf-token']);
      $('meta[name="csrf-param"]').attr('content', data['csrf-param']);
      log.info("Logged out on server");
      Seanchai.currentUser = null;
      Seanchai.LoginStateManager.transitionTo('notAuthenticated');
      return transition();
    },
    error: function(jqXHR, textStatus, errorThrown) {
      return alert("Error logging out: " + errorThrown);
    }
  });
};
