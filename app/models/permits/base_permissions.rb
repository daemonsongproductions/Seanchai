module Permits::BasePermissions

  def base_permissions
    allow :home, [:index]
    allow :sessions, [:new, :create, :destroy]
    allow :users, [:show, :create, :show_current_user]

    allow 'devise/passwords', [:new, :edit, :update, :create]
    allow 'devise/registrations', [:cancel, :create, :new, :edit, :update, :destroy]

    allow_param :user, :name
    allow_param :user, :username
    allow_param :user, :email
    allow_param :user, :password
    allow_param :user, :confirm_password

  end

end