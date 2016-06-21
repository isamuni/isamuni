Rails.application.routes.draw do
  
  get 'home/index'

  # User routing
  get 'me', to: 'profile#edit', as: 'edit_user'
  get 'users/typeahead(/query/:query)', to:'profile#typeahead'
  get 'users(/query/:query)', to: 'profile#index', as: 'users'
  get 'users/:id', to: 'profile#show', as: 'user'
  get 'profile/delete'
  get 'me/new', to: 'profile#new', as: 'new_user'
  post 'me', to: 'profile#create', as: 'create_user'
  patch 'users/:id', to: 'profile#update', as: 'update_user'

  resources :posts
  resources :pages
  #get 'session/create'

  get '/auth/:provider/callback', to: 'session#create'
  get '/auth/failure', to: 'session#auth_failure'
  get 'signout', to: 'session#destroy', as: 'signout'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
