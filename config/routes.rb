Lazyhackers4::Application.routes.draw do
  resources :parties_scopes

  resources :users_hacktags

  resources :parties_hacktags

  resources :hack_tag_follows

  resources :users_scopes

  resources :progres do
    member do
      post 'create_all'
    end
  end

  resources :hacks_scopes

  resources :hack_tags do
    collection do
      post 'create_hack_tag_and_hacks_scope'
    end
  end

  resources :scopes do
    member do
      post 'search_scope_from_hack_tags'
      post 'cheering'
      get 'from_search'
    end
    collection do
      get 'list'
    end
  end

  get "omniauth_callbacks/twitter"

  devise_for :users, :controllers => {:omniauth_callbacks => "omniauth_callbacks"} do
    get '/users/sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  get "users/index"
  resources :users
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "scopes#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
