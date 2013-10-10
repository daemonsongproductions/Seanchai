module Permits::BasePermissions

  def base_permissions
    allow :home, [:index]
    allow :sessions, [:new, :create, :destroy]
    allow :users, [:show, :create]
    allow 'devise/passwords', [:new, :edit, :update, :create]
    allow 'devise/registrations', [:cancel, :create, :new, :edit, :update, :destroy]

  end

end