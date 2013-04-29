Seanchai::Application.routes.draw do

  devise_for :users

  resources :chapters

  resources :section_types

  resources :sections

  resources :stories

  match 'admin' => 'admin#index'

  #map.namespace(:admin) do |admin|
  #  admin.resources(:stories, :controller => 'stories')
  #end

  # Profile routes
  #map.show_profile '/profile', :controller =>'profile', :action => 'show', :conditions => {:method => :get}
  #map.edit_profile '/profile/edit', :controller =>'profile', :action => 'edit'
  #map.new_profile '/profile/new', :controller => 'profile', :action => 'new'
  #map.update_profile '/profile', :controller => 'profile', :action => 'update', :conditions => {:method => :put}
  #map.create_profile '/profile', :controller => 'profile', :action => 'create', :conditions => {:method => :post}

  # Login routs
  #map.login '/login', :controller => 'login', :action => 'login', :conditions => {:method => :get}
  #map.authenticate '/login', :controller => 'login', :action => 'authenticate', :conditions => {:method => :post}
  #map.logout '/logout', :controller => 'login', :action => 'logout'
  #map.forgot_password '/login/forgot', :controller => 'login', :action => 'forgot_password'
  #map.reset_password '/login/reset', :controller => 'login', :action => 'reset_password', :conditions => {:method => :post}
  #map.password_reset_confirmation 'login/reset_confirmation', :controller =>'login', :action => 'reset_confirmation'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  root :to => "home#show"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  match ':controller/:action/:id/'
  match ':controller/:action/:id.:format'
end
